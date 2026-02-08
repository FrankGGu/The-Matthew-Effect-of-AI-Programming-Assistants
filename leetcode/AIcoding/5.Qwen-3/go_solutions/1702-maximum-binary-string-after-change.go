package main

func minOperationsToMakeBinaryStringBeautiful(binary string) int {
    n := len(binary)
    res := 0
    for i := 0; i < n; i++ {
        if binary[i] == '0' {
            res++
        }
    }
    return res
}