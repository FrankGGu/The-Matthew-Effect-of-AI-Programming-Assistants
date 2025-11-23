func firstDayBeenInAllRooms(nextVisit []int) int {
    const mod = 1e9 + 7
    n := len(nextVisit)
    dp := make([]int, n)
    dp[0] = 0
    for i := 1; i < n; i++ {
        dp[i] = (2*dp[i-1] - dp[nextVisit[i-1]] + 2) % mod
        if dp[i] < 0 {
            dp[i] += mod
        }
    }
    return dp[n-1]
}