func countRoutes(locations []int, start int, finish int, fuel int) int {
    mod := 1_000_000_007
    n := len(locations)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, fuel+1)
    }

    var dfs func(pos, fuel int) int
    dfs = func(pos, fuel int) int {
        if fuel < 0 {
            return 0
        }
        if dp[pos][fuel] != 0 {
            return dp[pos][fuel]
        }
        count := 0
        if pos == finish {
            count = 1
        }
        for next := 0; next < n; next++ {
            if next != pos {
                cost := abs(locations[next] - locations[pos])
                count = (count + dfs(next, fuel-cost)) % mod
            }
        }
        dp[pos][fuel] = count
        return count
    }

    return dfs(start, fuel)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}