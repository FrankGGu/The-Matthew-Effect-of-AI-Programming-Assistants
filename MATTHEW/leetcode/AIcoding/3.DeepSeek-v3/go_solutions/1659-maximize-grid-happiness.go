func getMaxGridHappiness(m int, n int, introvertsCount int, extrovertsCount int) int {
    maxState := 1
    for i := 0; i < n; i++ {
        maxState *= 3
    }
    dp := make([][][][]int, m*n+1)
    for i := range dp {
        dp[i] = make([][][]int, introvertsCount+1)
        for j := range dp[i] {
            dp[i][j] = make([][]int, extrovertsCount+1)
            for k := range dp[i][j] {
                dp[i][j][k] = make([]int, maxState)
                for l := range dp[i][j][k] {
                    dp[i][j][k][l] = -1
                }
            }
        }
    }

    var dfs func(pos, in, ex, prevState int) int
    dfs = func(pos, in, ex, prevState int) int {
        if pos == m*n {
            return 0
        }
        if dp[pos][in][ex][prevState] != -1 {
            return dp[pos][in][ex][prevState]
        }

        res := dfs(pos+1, in, ex, prevState%3*3)

        x, y := pos/n, pos%n
        up := prevState / (maxState / 3)
        left := prevState % 3
        if y == 0 {
            left = 0
        }

        if in > 0 {
            score := 120
            if up == 1 {
                score -= 30
            } else if up == 2 {
                score -= 20
            }
            if left == 1 {
                score -= 30
            } else if left == 2 {
                score -= 20
            }
            newState := prevState%3*3 + 1
            res = max(res, score+dfs(pos+1, in-1, ex, newState))
        }

        if ex > 0 {
            score := 40
            if up == 1 {
                score -= 20
            } else if up == 2 {
                score += 20
            }
            if left == 1 {
                score -= 20
            } else if left == 2 {
                score += 20
            }
            newState := prevState%3*3 + 2
            res = max(res, score+dfs(pos+1, in, ex-1, newState))
        }

        dp[pos][in][ex][prevState] = res
        return res
    }

    return dfs(0, introvertsCount, extrovertsCount, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}