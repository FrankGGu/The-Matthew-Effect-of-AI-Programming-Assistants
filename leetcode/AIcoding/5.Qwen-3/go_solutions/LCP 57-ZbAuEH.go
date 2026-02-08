package main

func getMaximumGold(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || i >= m || j < 0 || j >= n || grid[i][j] == 0 {
            return 0
        }
        maxGold := grid[i][j]
        temp := grid[i][j]
        grid[i][j] = 0
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            maxGold = max(maxGold, temp+dfs(ni, nj))
        }
        grid[i][j] = temp
        return maxGold
    }
    result := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            result = max(result, dfs(i, j))
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}