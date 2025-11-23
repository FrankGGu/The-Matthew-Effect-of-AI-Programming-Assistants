package main

import "math"

func mergeStones(stones []int, K int) int {
    n := len(stones)
    if (n-1)%(K-1) != 0 {
        return -1
    }

    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, K+1)
            for k := range dp[i][j] {
                dp[i][j][k] = math.MaxInt32
            }
        }
    }

    prefixSum := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefixSum[i] = prefixSum[i-1] + stones[i-1]
    }

    for i := 0; i < n; i++ {
        dp[i][i][1] = 0
    }

    for length := 2; length <= n; length++ {
        for l := 0; l <= n-length; l++ {
            r := l + length - 1
            for k := 1; k <= K; k++ {
                for m := l; m < r; m++ {
                    dp[l][r][k] = min(dp[l][r][k], dp[l][m][k]+dp[m+1][r][k])
                }
                if k > 1 && (length-1)%(K-1) == 0 {
                    dp[l][r][1] = min(dp[l][r][1], dp[l][r][k]+prefixSum[r+1]-prefixSum[l])
                }
            }
        }
    }

    return dp[0][n-1][1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}