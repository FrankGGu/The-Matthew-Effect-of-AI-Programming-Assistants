func maxValueSum(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, k+1)
            for l := range dp[i][j] {
                dp[i][j][l] = -1
            }
        }
    }

    var dfs func(i, j, l int) int
    dfs = func(i, j, l int) int {
        if i == m || j == n {
            return 0
        }
        if dp[i][j][l] != -1 {
            return dp[i][j][l]
        }
        res := 0
        if l > 0 {
            res = max(res, grid[i][j] + dfs(i+1, j, l-1))
            res = max(res, grid[i][j] + dfs(i, j+1, l-1))
        }
        res = max(res, dfs(i+1, j, l))
        res = max(res, dfs(i, j+1, l))
        dp[i][j][l] = res
        return res
    }

    return dfs(0, 0, 3)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}