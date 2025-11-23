package main

func countSquareFreeSubsets(nums []int) int {
    mod := 1000000007
    dp := make(map[int]int)
    dp[0] = 1

    for _, num := range nums {
        if num == 0 {
            continue
        }
        for mask := range dp {
            if (mask & num) == 0 {
                newMask := mask | num
                dp[newMask] = (dp[newMask] + dp[mask]) % mod
            }
        }
    }

    result := 0
    for mask := range dp {
        if mask != 0 {
            result = (result + dp[mask]) % mod
        }
    }

    return result
}