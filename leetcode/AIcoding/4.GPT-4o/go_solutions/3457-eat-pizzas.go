package main

import "sort"

func maxSlices(pizza []string, k int) int {
    m, n := len(pizza), len(pizza[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            prefix[i][j] = prefix[i+1][j] + prefix[i][j+1] - prefix[i+1][j+1]
            if pizza[i][j] == 'A' {
                prefix[i][j]++
            }
        }
    }

    dp := make([][][]int, k+1)
    for i := range dp {
        dp[i] = make([][]int, m)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
        }
    }

    for i := 1; i <= k; i++ {
        for x1 := 0; x1 < m; x1++ {
            for y1 := 0; y1 < n; y1++ {
                for x2 := x1; x2 < m; x2++ {
                    for y2 := y1; y2 < n; y2++ {
                        apples := prefix[x1][y1] - prefix[x2+1][y1] - prefix[x1][y2+1] + prefix[x2+1][y2+1]
                        dp[i][x2][y2] = max(dp[i][x2][y2], apples)
                    }
                }
            }
        }

        for x1 := 0; x1 < m; x1++ {
            for y1 := 0; y1 < n; y1++ {
                for x2 := 0; x2 < m; x2++ {
                    for y2 := 0; y2 < n; y2++ {
                        dp[i][x2][y2] = max(dp[i][x2][y2], dp[i-1][x1][y1])
                    }
                }
            }
        }
    }

    result := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result = max(result, dp[k][i][j])
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}