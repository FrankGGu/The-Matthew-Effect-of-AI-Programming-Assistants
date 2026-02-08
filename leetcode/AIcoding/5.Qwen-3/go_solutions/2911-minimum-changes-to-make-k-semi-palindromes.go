package main

func minimumChanges(s string, k int) int {
    n := len(s)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                if length == 2 {
                    dp[i][j] = 0
                } else {
                    dp[i][j] = dp[i+1][j-1]
                }
            } else {
                dp[i][j] = 1 + dp[i+1][j-1]
            }
        }
    }

    minChanges := func(i, j int) int {
        return dp[i][j]
    }

    m := n
    cost := make([][]int, m)
    for i := range cost {
        cost[i] = make([]int, m)
    }

    for i := 0; i < m; i++ {
        for j := i + 1; j < m; j++ {
            cost[i][j] = minChanges(i, j)
        }
    }

    dp2 := make([][]int, m)
    for i := range dp2 {
        dp2[i] = make([]int, k+1)
    }

    for i := 0; i < m; i++ {
        for j := 1; j <= k; j++ {
            if j == 1 {
                dp2[i][j] = cost[i][m-1]
            } else {
                dp2[i][j] = 1 << 63
                for l := i; l < m-1; l++ {
                    if dp2[l+1][j-1] != 0 && dp2[i][j] > dp2[l+1][j-1]+cost[i][l] {
                        dp2[i][j] = dp2[l+1][j-1] + cost[i][l]
                    }
                }
            }
        }
    }

    return dp2[0][k]
}