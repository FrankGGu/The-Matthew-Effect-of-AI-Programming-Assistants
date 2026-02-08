func firstDayBeenInAllRooms(days []int) int {
    const mod = 1e9 + 7
    n := len(days)
    dp := make([]int, n)
    dp[0] = 0

    for i := 1; i < n; i++ {
        dp[i] = (dp[i-1] + days[i-1]) % mod
    }

    total := 0
    for i := 1; i < n; i++ {
        total = (total + dp[i]) % mod
    }

    return (total + n) % mod
}