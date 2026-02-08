func minDistance(word1 string, word2 string) int {
    m := len(word1)
    n := len(word2)

    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := 0; i <= m; i++ {
        dp[i][0] = i
    }
    for j := 0; j <= n; j++ {
        dp[0][j] = j
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            if word1[i-1] == word2[j-1] {
                dp[i][j] = dp[i-1][j-1]
            } else {
                minVal := dp[i-1][j-1] // Replace
                if dp[i-1][j] < minVal { // Delete
                    minVal = dp[i-1][j]
                }
                if dp[i][j-1] < minVal { // Insert
                    minVal = dp[i][j-1]
                }
                dp[i][j] = 1 + minVal
            }
        }
    }

    return dp[m][n]
}