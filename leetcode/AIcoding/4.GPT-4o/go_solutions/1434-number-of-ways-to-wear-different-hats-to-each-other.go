func numWays(hats [][]int) int {
    const mod = 1000000007
    n := len(hats)
    hatToPeople := make(map[int][]int)

    for i := 0; i < n; i++ {
        for _, hat := range hats[i] {
            hatToPeople[hat] = append(hatToPeople[hat], i)
        }
    }

    totalHats := len(hatToPeople)
    dp := make([]int, 1<<n)
    dp[0] = 1

    for _, people := range hatToPeople {
        for mask := (1 << n) - 1; mask >= 0; mask-- {
            for _, person := range people {
                if mask&(1<<person) == 0 {
                    dp[mask|(1<<person)] = (dp[mask|(1<<person)] + dp[mask]) % mod
                }
            }
        }
    }

    return dp[(1<<n)-1]
}