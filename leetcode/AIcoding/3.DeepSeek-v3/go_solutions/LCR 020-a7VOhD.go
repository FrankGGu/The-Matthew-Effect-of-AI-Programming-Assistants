func countSubstrings(s string) int {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }
    count := 0

    for i := 0; i < n; i++ {
        dp[i][i] = true
        count++
    }

    for i := 0; i < n-1; i++ {
        if s[i] == s[i+1] {
            dp[i][i+1] = true
            count++
        }
    }

    for length := 3; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            if s[i] == s[j] && dp[i+1][j-1] {
                dp[i][j] = true
                count++
            }
        }
    }

    return count
}