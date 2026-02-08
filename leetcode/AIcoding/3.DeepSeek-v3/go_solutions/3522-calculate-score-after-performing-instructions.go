func calculateScore(instructions []int, scores []int, startPos int) int {
    n := len(instructions)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for l := 1; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            j := i + l - 1
            if i == j {
                dp[i][j] = scores[startPos]
                continue
            }
            left := instructions[i]
            right := instructions[j]
            if left == right {
                if l == 2 {
                    dp[i][j] = scores[left] * 2
                } else {
                    dp[i][j] = scores[left] * 2 + dp[i+1][j-1]
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