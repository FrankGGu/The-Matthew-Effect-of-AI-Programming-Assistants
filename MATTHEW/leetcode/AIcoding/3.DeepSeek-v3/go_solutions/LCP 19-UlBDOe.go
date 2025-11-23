func minimumOperations(leaves string) int {
    n := len(leaves)
    dp := make([][3]int, n)

    for i := 0; i < n; i++ {
        if i < 1 {
            if leaves[i] == 'r' {
                dp[i][0] = 0
            } else {
                dp[i][0] = 1
            }
            dp[i][1] = n
            dp[i][2] = n
            continue
        }

        if leaves[i] == 'r' {
            dp[i][0] = dp[i-1][0]
            dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + 1
            dp[i][2] = min(dp[i-1][1], dp[i-1][2])
        } else {
            dp[i][0] = dp[i-1][0] + 1
            dp[i][1] = min(dp[i-1][0], dp[i-1][1])
            dp[i][2] = min(dp[i-1][1], dp[i-1][2]) + 1
        }
    }

    return dp[n-1][2]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}