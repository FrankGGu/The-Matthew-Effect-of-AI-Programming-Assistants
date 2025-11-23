func getLengthOfOptimalCompression(s string, k int) int {
    n := len(s)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = 100000
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            if j > 0 {
                dp[i][j] = min(dp[i][j], dp[i-1][j-1])
            }
            count := 0
            diff := 0
            for l := i; l >= 1; l-- {
                if s[l-1] == s[i-1] {
                    count++
                } else {
                    diff++
                }
                if j >= diff {
                    dp[i][j] = min(dp[i][j], dp[l-1][j-diff]+length(count))
                }
            }
        }
    }

    result := 100000
    for j := 0; j <= k; j++ {
        result = min(result, dp[n][j])
    }
    return result
}

func length(count int) int {
    if count == 1 {
        return 1
    } else if count < 10 {
        return 2
    } else if count < 100 {
        return 3
    } else {
        return 4
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}