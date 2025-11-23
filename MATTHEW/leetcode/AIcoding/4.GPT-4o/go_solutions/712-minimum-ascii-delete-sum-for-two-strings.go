func minimumDeleteSum(s1 string, s2 string) int {
    m, n := len(s1), len(s2)
    dp := make([]int, n+1)

    for j := 0; j <= n; j++ {
        if j == 0 {
            dp[j] = 0
        } else {
            dp[j] = dp[j-1] + int(s2[j-1])
        }
    }

    for i := 1; i <= m; i++ {
        prev := dp[0]
        dp[0] += int(s1[i-1])
        for j := 1; j <= n; j++ {
            temp := dp[j]
            if s1[i-1] == s2[j-1] {
                dp[j] = prev
            } else {
                dp[j] = min(dp[j]+int(s1[i-1]), dp[j-1]+int(s2[j-1]))
            }
            prev = temp
        }
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}