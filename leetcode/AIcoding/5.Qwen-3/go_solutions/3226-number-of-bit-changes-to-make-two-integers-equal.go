package main

func minBitChanges(n int, m int) int {
    return bits.OnesCount(uint(n ^ m))
}