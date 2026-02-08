func longestPalindromeSubseq(s string, k int) int {
    n := len(s)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        dp[i][i] = 1
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                dp[i][j] = dp[i+1][j-1] + 2
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j-1])
            }
        }
    }

    maxOps := make([][]int, n)
    for i := range maxOps {
        maxOps[i] = make([]int, n)
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                maxOps[i][j] = maxOps[i+1][j-1]
            } else {
                maxOps[i][j] = maxOps[i+1][j-1] + 1
            }
        }
    }

    res := 0
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            if maxOps[i][j] <= k {
                res = max(res, dp[i][j])
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}