func countPalindromicSubsequences(s string) int {
    n := len(s)
    mod := 1000000007
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, 4)
        }
    }

    for i := 0; i < n; i++ {
        dp[i][i][0] = 1
        dp[i][i][1] = 1
        dp[i][i][2] = 1
        dp[i][i][3] = 1
    }

    for length := 2; length <= n; length++ {
        for start := 0; start <= n-length; start++ {
            end := start + length - 1
            if s[start] == s[end] {
                for k := 0; k < 4; k++ {
                    dp[start][end][k] = (dp[start+1][end][k] + dp[start][end-1][k] + 1) % mod
                }
            } else {
                for k := 0; k < 4; k++ {
                    dp[start][end][k] = (dp[start+1][end][k] + dp[start][end-1][k] - dp[start+1][end-1][k] + mod) % mod
                }
            }
        }
    }

    return (dp[0][n-1][0] + dp[0][n-1][1] + dp[0][n-1][2] + dp[0][n-1][3]) % mod
}