func catMouseGame(graph [][]int) int {
    n := len(graph)
    dp := make([][][]int, 2*n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }

    var dfs func(t, mouse, cat int) int
    dfs = func(t, mouse, cat int) int {
        if t == 2 * n {
            return 0
        }
        if mouse == cat {
            return 2
        }
        if mouse == 0 {
            return 1
        }
        if dp[t][mouse][cat] != -1 {
            return dp[t][mouse][cat]
        }

        if t % 2 == 0 {
            draw := false
            for _, next := range graph[mouse] {
                res := dfs(t+1, next, cat)
                if res == 1 {
                    dp[t][mouse][cat] = 1
                    return 1
                }
                if res == 0 {
                    draw = true
                }
            }
            if draw {
                dp[t][mouse][cat] = 0
                return 0
            } else {
                dp[t][mouse][cat] = 2
                return 2
            }
        } else {
            draw := false
            for _, next := range graph[cat] {
                if next == 0 {
                    continue
                }
                res := dfs(t+1, mouse, next)
                if res == 2 {
                    dp[t][mouse][cat] = 2
                    return 2
                }
                if res == 0 {
                    draw = true
                }
            }
            if draw {
                dp[t][mouse][cat] = 0
                return 0
            } else {
                dp[t][mouse][cat] = 1
                return 1
            }
        }
    }

    return dfs(0, 1, 2)
}