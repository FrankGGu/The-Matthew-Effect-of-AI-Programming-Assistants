package main

func minBitFlips(target int, initial int) int {
    flips := 0
    xor := target ^ initial
    for xor > 0 {
        flips += xor & 1
        xor >>= 1
    }
    return flips
}