package main

func kDisjointSpecialSubstrings(s string, k int) int {
    n := len(s)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if i == j {
                dp[i][j] = 1
            } else {
                dp[i][j] = dp[i][j-1]
                if s[i] == s[j] {
                    if i+1 <= j-1 {
                        dp[i][j] = max(dp[i][j], dp[i+1][j-1]+2)
                    } else {
                        dp[i][j] = max(dp[i][j], 2)
                    }
                }
            }
        }
    }

    maxLen := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if dp[i][j] > maxLen {
                maxLen = dp[i][j]
            }
        }
    }

    if maxLen < 2*k {
        return -1
    }

    special := make([]int, 0)
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if dp[i][j] >= 2 {
                special = append(special, dp[i][j])
            }
        }
    }

    sort.Ints(special)

    res := 0
    for i := len(special) - 1; i >= len(special)-k && i >= 0; i-- {
        res += special[i]
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}