func nthUglyNumber(n int) int {
    dp := make([]int, n)
    dp[0] = 1
    idx2, idx3, idx5 := 0, 0, 0
    for i := 1; i < n; i++ {
        next2, next3, next5 := dp[idx2]*2, dp[idx3]*3, dp[idx5]*5
        dp[i] = min(next2, min(next3, next5))
        if dp[i] == next2 {
            idx2++
        }
        if dp[i] == next3 {
            idx3++
        }
        if dp[i] == next5 {
            idx5++
        }
    }
    return dp[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}