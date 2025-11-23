package main

func removeBoxes(boxes string) string {
    n := len(boxes)
    dp := make([][]string, n)
    for i := range dp {
        dp[i] = make([]string, n)
    }
    for i := 0; i < n; i++ {
        dp[i][i] = boxes[i:i+1]
    }
    for length := 2; length <= n; length++ {
        for i := 0; i <= n-length; i++ {
            j := i + length - 1
            dp[i][j] = dp[i][j-1]
            if boxes[j] > dp[i][j-1][0] {
                dp[i][j] = boxes[j:j+1] + dp[i][j-1]
            } else if boxes[j] == dp[i][j-1][0] {
                if len(dp[i][j-1]) > 1 {
                    dp[i][j] = boxes[j:j+1] + dp[i][j-1]
                } else {
                    dp[i][j] = dp[i][j-1]
                }
            }
        }
    }
    return dp[0][n-1]
}