func findRotateSteps(ring string, key string) int {
    m, n := len(ring), len(key)
    pos := make(map[byte][]int)
    for i := 0; i < m; i++ {
        c := ring[i]
        pos[c] = append(pos[c], i)
    }
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(int, int) int
    dfs = func(i, j int) int {
        if j == n {
            return 0
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }
        res := math.MaxInt32
        for _, k := range pos[key[j]] {
            d := abs(k - i)
            step := min(d, m - d)
            res = min(res, step + dfs(k, j + 1))
        }
        dp[i][j] = res + 1
        return dp[i][j]
    }
    return dfs(0, 0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}