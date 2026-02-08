package main

func bitwiseComplement(n int) int {
    if n == 0 {
        return 1
    }
    mask := 1
    for mask < n {
        mask = (mask << 1) | 1
    }
    return n ^ mask
}