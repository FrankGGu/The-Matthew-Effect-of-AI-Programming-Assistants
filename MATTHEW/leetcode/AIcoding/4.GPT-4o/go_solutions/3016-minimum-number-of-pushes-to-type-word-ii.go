func minimumPushes(pressed string, target string) int {
    n := len(pressed)
    m := len(target)
    dp := make([]int, m+1)

    for i := 1; i <= m; i++ {
        dp[i] = i
    }

    for i := 1; i <= n; i++ {
        prev := dp[0]
        dp[0] = i
        for j := 1; j <= m; j++ {
            temp := dp[j]
            if pressed[i-1] == target[j-1] {
                dp[j] = prev
            } else {
                dp[j] = min(dp[j], dp[j-1]) + 1
            }
            prev = temp
        }
    }

    return dp[m]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}