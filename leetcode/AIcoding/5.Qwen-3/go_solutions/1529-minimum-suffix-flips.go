package main

func minFlips(s string) int {
    flips := 0
    prev := '0'
    for _, c := range s {
        if c != prev {
            flips++
            prev = c
        }
    }
    return flips
}