package main

func numShortestSupersequences(queries []string, pattern string) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        res[i] = count(q, pattern)
    }
    return res
}

func count(s, p string) int {
    n, m := len(s), len(p)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 0; i <= n; i++ {
        dp[i][m] = 1
    }
    for j := 0; j < m; j++ {
        dp[n][j] = 0
    }
    for i := n - 1; i >= 0; i-- {
        for j := m - 1; j >= 0; j-- {
            if s[i] == p[j] {
                dp[i][j] = dp[i+1][j+1]
            } else {
                dp[i][j] = dp[i+1][j]
            }
        }
    }
    return dp[0][0]
}