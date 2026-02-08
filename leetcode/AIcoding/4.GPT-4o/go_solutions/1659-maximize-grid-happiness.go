package main

import "math"

func getMaxHappiness(m, n, introvertsCount, extrovertsCount int) int {
    dp := make([][][][]int, introvertsCount+1)
    for i := range dp {
        dp[i] = make([][][]int, extrovertsCount+1)
        for j := range dp[i] {
            dp[i][j] = make([][]int, m*n+1)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }
    return backtrack(m, n, introvertsCount, extrovertsCount, 0, 0, 0, dp)
}

func backtrack(m, n, introvertsCount, extrovertsCount, row, col, occupied int, dp [][][][]int) int {
    if introvertsCount < 0 || extrovertsCount < 0 {
        return math.MinInt32
    }
    if row == m {
        return 0
    }
    if col == n {
        return backtrack(m, n, introvertsCount, extrovertsCount, row+1, 0, occupied, dp)
    }
    if dp[introvertsCount][extrovertsCount][occupied] != -1 {
        return dp[introvertsCount][extrovertsCount][occupied]
    }

    maxHappiness := backtrack(m, n, introvertsCount, extrovertsCount, row, col+1, occupied, dp)

    if introvertsCount > 0 {
        maxHappiness = max(maxHappiness, 120+backtrack(m, n, introvertsCount-1, extrovertsCount, row, col+1, occupied+1, dp))
    }
    if extrovertsCount > 0 {
        maxHappiness = max(maxHappiness, 40+backtrack(m, n, introvertsCount, extrovertsCount-1, row, col+1, occupied+1, dp))
    }

    dp[introvertsCount][extrovertsCount][occupied] = maxHappiness
    return maxHappiness
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}