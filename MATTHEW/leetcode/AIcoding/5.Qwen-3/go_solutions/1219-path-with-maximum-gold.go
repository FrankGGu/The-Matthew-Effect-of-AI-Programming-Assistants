package main

func getMaximumGold(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    maxGold := 0

    var dfs func(int, int) int
    dfs = func(r, c int) int {
        if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
            return 0
        }

        currentGold := grid[r][c]
        grid[r][c] = 0 // mark as visited

        maxNext := 0
        directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
        for _, d := range directions {
            nr, nc := r + d[0], c + d[1]
            maxNext = max(maxNext, dfs(nr, nc))
        }

        grid[r][c] = currentGold // backtrack
        return currentGold + maxNext
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            maxGold = max(maxGold, dfs(i, j))
        }
    }

    return maxGold
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}