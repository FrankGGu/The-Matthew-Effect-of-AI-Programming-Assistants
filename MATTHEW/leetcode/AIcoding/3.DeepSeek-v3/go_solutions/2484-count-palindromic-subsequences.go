func countPalindromicSubsequences(s string) int {
    const MOD = 1e9 + 7
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
                left, right := i+1, j-1
                for left <= right && s[left] != s[i] {
                    left++
                }
                for left <= right && s[right] != s[i] {
                    right--
                }
                if left > right {
                    dp[i][j] = dp[i+1][j-1]*2 + 2
                } else if left == right {
                    dp[i][j] = dp[i+1][j-1]*2 + 1
                } else {
                    dp[i][j] = dp[i+1][j-1]*2 - dp[left+1][right-1]
                }
            } else {
                dp[i][j] = dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1]
            }
            if dp[i][j] < 0 {
                dp[i][j] += MOD
            } else {
                dp[i][j] %= MOD
            }
        }
    }
    return dp[0][n-1]
}