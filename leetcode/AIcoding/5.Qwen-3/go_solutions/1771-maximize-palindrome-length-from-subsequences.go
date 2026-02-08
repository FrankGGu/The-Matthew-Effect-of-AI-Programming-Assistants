package main

func maxPalindromeLength(word string) int {
    n := len(word)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        dp[i][i] = 1
    }

    for l := 2; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            if word[i] == word[j] {
                if l == 2 {
                    dp[i][j] = 2
                } else {
                    dp[i][j] = dp[i+1][j-1] + 2
                }
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j-1])
            }
        }
    }

    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}