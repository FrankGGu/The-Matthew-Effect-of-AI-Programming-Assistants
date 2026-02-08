package main

func smallestNumber(n int) int {
    if n == 0 {
        return 1
    }
    bits := 0
    for i := n; i > 0; i >>= 1 {
        bits++
    }
    return (1 << bits) - 1
}