func minSideJumps(obstacles []int) int {
    n := len(obstacles) - 1
    dp := [3]int{1, 0, 1}
    for i := 1; i <= n; i++ {
        for j := 0; j < 3; j++ {
            if obstacles[i] == j+1 {
                dp[j] = 1000000
            }
        }
        minVal := 1000000
        for j := 0; j < 3; j++ {
            if dp[j] < minVal {
                minVal = dp[j]
            }
        }
        for j := 0; j < 3; j++ {
            if dp[j] == 1000000 {
                continue
            }
            if j > 0 && dp[j-1] != 1000000 {
                dp[j] = min(dp[j], dp[j-1]+1)
            }
            if j < 2 && dp[j+1] != 1000000 {
                dp[j] = min(dp[j], dp[j+1]+1)
            }
            dp[j] = min(dp[j], minVal)
        }
    }
    return min(dp[0], min(dp[1], dp[2]))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}