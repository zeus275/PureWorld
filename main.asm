// vim: ft=snes
arch snes.cpu

fill $200000

macro seek(variable offset) {
  origin ((offset & $7F0000) >> 1) | (offset & $7FFF)
  base offset
}

include "header.snes.asm" // Include Header & Vector Table

seek($8000)
  clc
  nop
  // |       main_Loop
  main_loop:
  -;jsr ++ //  |__________Joy__________+-
    jsr + //   |__________Draw_________|
    lda $02
    clc
    adc #$01
    sta $02
    bra -

  draw: // | Draw Sprite On Screen
  +;rts

  right_move:
  +;lda $ff
    cmp #$77
    bne + // If flag zero bit = 1
    inc $03

  left_move:
  +;lda $ff
    cmp #$73
    bne +
    dec $03

  nomove:
  +;rts