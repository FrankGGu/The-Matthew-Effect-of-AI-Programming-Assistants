package main

import "math"

func connectTwoGroups(arr1 []int, arr2 []int) int {
    n := len(arr1)
    m := len(arr2)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }
    dp[0][0] = 0

    for i := 0; i < n; i++ {
        for j := 0; j <= m; j++ {
            if dp[i][j] == math.MaxInt32 {
                continue
            }
            // Connect arr1[i] to nothing
            dp[i+1][j] = min(dp[i+1][j], dp[i][j])
            // Connect arr1[i] to some point in arr2
            for k := 0; k < m; k++ {
                cost := arr1[i] + arr2[k]
                if j&(1<<k) == 0 {
                    newJ := j | (1 << k)
                    dp[i+1][newJ] = min(dp[i+1][newJ], dp[i][j]+cost)
                } else {
                    dp[i+1][j] = min(dp[i+1][j], dp[i][j]+cost)
                }
            }
        }
    }

    res := math.MaxInt32
    for j := 0; j < (1 << m); j++ {
        res = min(res, dp[n][j])
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}