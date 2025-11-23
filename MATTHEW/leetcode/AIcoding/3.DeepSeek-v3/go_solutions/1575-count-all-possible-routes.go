func countRoutes(locations []int, start int, finish int, fuel int) int {
    const mod = 1e9 + 7
    n := len(locations)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, fuel+1)
    }
    dp[finish][0] = 1

    for f := 1; f <= fuel; f++ {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if i == j {
                    continue
                }
                cost := abs(locations[i] - locations[j])
                if cost <= f {
                    dp[i][f] = (dp[i][f] + dp[j][f-cost]) % mod
                }
            }
        }
    }

    res := 0
    for f := 0; f <= fuel; f++ {
        res = (res + dp[start][f]) % mod
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}