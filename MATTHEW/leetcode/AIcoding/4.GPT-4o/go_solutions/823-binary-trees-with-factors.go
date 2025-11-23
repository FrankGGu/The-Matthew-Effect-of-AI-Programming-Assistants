package main

import "sort"

func numFactoredBinaryTrees(arr []int) int {
    const mod = 1_000_000_007
    sort.Ints(arr)
    n := len(arr)
    dp := make(map[int]int)
    for _, x := range arr {
        dp[x] = 1
        for _, y := range arr {
            if y >= x {
                break
            }
            if x%y == 0 {
                z := x / y
                if _, exists := dp[z]; exists {
                    dp[x] = (dp[x] + dp[y]*dp[z]) % mod
                }
            }
        }
    }
    result := 0
    for _, count := range dp {
        result = (result + count) % mod
    }
    return result
}