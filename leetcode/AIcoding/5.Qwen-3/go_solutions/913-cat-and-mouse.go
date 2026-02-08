package main

func catMouseGame(mousePositions []int, catPositions []int, time int) int {
    n := len(mousePositions)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            dp[i][j] = -1
        }
    }

    var dfs func(int, int, int) int
    dfs = func(m, c, t int) int {
        if t >= 2*n {
            return 0
        }
        if dp[m][c] != -1 {
            return dp[m][c]
        }
        if m == 0 {
            dp[m][c] = 1
            return 1
        }
        if m == c {
            dp[m][c] = 2
            return 2
        }

        if t%2 == 0 {
            for _, next := range mousePositions[m] {
                res := dfs(next, c, t+1)
                if res == 1 {
                    dp[m][c] = 1
                    return 1
                }
            }
            dp[m][c] = 2
            return 2
        } else {
            for _, next := range catPositions[c] {
                res := dfs(m, next, t+1)
                if res == 2 {
                    dp[m][c] = 2
                    return 2
                }
            }
            dp[m][c] = 1
            return 1
        }
    }

    return dfs(mousePositions[0], catPositions[0], 0)
}