func shortestBridge(grid [][]int) int {
    n := len(grid)
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    queue := make([][]int, 0)
    found := false

    for i := 0; i < n && !found; i++ {
        for j := 0; j < n && !found; j++ {
            if grid[i][j] == 1 {
                dfs(&grid, i, j, n, &queue)
                found = true
            }
        }
    }

    steps := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            for _, dir := range dirs {
                x := cell[0] + dir[0]
                y := cell[1] + dir[1]
                if x >= 0 && x < n && y >= 0 && y < n {
                    if grid[x][y] == 1 {
                        return steps
                    }
                    if grid[x][y] == 0 {
                        grid[x][y] = 2
                        queue = append(queue, []int{x, y})
                    }
                }
            }
        }
        steps++
    }
    return -1
}

func dfs(grid *[][]int, i, j, n int, queue *[][]int) {
    if i < 0 || i >= n || j < 0 || j >= n || (*grid)[i][j] != 1 {
        return
    }
    (*grid)[i][j] = 2
    *queue = append(*queue, []int{i, j})
    dfs(grid, i-1, j, n, queue)
    dfs(grid, i+1, j, n, queue)
    dfs(grid, i, j-1, n, queue)
    dfs(grid, i, j+1, n, queue)
}