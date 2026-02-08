func checkPartitioning(s string) bool {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
        dp[i][i] = true
    }

    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] {
                if length == 2 || dp[i+1][j-1] {
                    dp[i][j] = true
                }
            }
        }
    }

    for i := 1; i < n-1; i++ {
        for j := i; j < n-1; j++ {
            if dp[0][i-1] && dp[i][j] && dp[j+1][n-1] {
                return true
            }
        }
    }
    return false
}