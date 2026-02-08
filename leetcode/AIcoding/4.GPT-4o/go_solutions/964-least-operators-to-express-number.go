package main

import "math"

func leastOpsExpressTarget(x int, target int) int {
    if target == 0 {
        return 0
    }

    dp := make([]int, target+1)
    for i := 1; i <= target; i++ {
        dp[i] = math.MaxInt32
    }

    for i := 1; i <= target; i++ {
        j := i
        for j > 0 {
            dp[i] = min(dp[i], dp[i-j]+1)
            j /= x
        }
        dp[i] = min(dp[i], dp[i-1]+1)
    }

    return dp[target]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}