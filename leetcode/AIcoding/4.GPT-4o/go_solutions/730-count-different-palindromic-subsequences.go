func countPalindromicSubsequences(s string) int {
    n := len(s)
    mod := 1000000007
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for length := 1; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if i == j {
                dp[i][j] = 1
            } else if s[i] == s[j] {
                left, right := i+1, j-1
                for left <= right && s[left] != s[i] {
                    left++
                }
                for right >= left && s[right] != s[j] {
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
                dp[i][j] = (dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + mod) % mod
            }
        }
    }
    return dp[0][n-1]
}