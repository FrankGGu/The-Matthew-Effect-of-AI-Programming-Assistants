func longestPalindrome(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    maxLen := 1
    for i := 0; i < n; i++ {
        dp[i][i] = true
    }

    for i := 0; i < n-1; i++ {
        if s[i] == s[i+1] {
            dp[i][i+1] = true
            maxLen = 2
        }
    }

    for length := 3; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] && dp[i+1][j-1] {
                dp[i][j] = true
                if length > maxLen {
                    maxLen = length
                }
            }
        }
    }

    return maxLen
}