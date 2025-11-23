package main

func minFlips(n int) int {
    bits := make([]int, 32)
    for i := 0; i < 32; i++ {
        bits[i] = (n >> i) & 1
    }
    res := 0
    for i := 1; i < 32; i++ {
        if bits[i] == bits[i-1] {
            res++
            bits[i] ^= 1
        }
    }
    return res
}