package main

func minCost(houses []int, cost []int, m int, n int, k int) int {
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, k)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < k; j++ {
            if i == 0 {
                if houses[i] == 0 {
                    dp[i][j] = cost[i][j]
                } else {
                    if j == houses[i]-1 {
                        dp[i][j] = 0
                    } else {
                        dp[i][j] = -1
                    }
                }
            } else {
                for prevColor := 0; prevColor < n; prevColor++ {
                    if dp[i-1][prevColor] == -1 {
                        continue
                    }
                    if houses[i] == 0 {
                        dp[i][j] = min(dp[i][j], dp[i-1][prevColor]+cost[i][j])
                    } else {
                        if j == houses[i]-1 {
                            dp[i][j] = min(dp[i][j], dp[i-1][prevColor])
                        }
                    }
                }
            }
        }
    }

    res := -1
    for i := 0; i < n; i++ {
        if dp[m-1][i] != -1 {
            if res == -1 || dp[m-1][i] < res {
                res = dp[m-1][i]
            }
        }
    }
    return res
}

func min(a, b int) int {
    if a == -1 {
        return b
    }
    if b == -1 {
        return a
    }
    if a < b {
        return a
    }
    return b
}