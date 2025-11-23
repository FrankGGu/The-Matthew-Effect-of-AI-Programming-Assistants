func minimumTotalDistance(locations [][]int) int {
    n := len(locations)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(int, int) int
    dfs = func(i, j int) int {
        if i == n {
            return 0
        }
        if j == n {
            return dfs(i + 1, i + 1)
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }

        cost := 0
        for k := i; k < j; k++ {
            cost += abs(locations[k][0] - locations[j][0]) + abs(locations[k][1] - locations[j][1])
        }
        dp[i][j] = min(dfs(i, j + 1), cost + dfs(i + 1, i + 1))
        return dp[i][j]
    }

    return dfs(0, 0)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}