package main

func shortestBridge(grid [][]int) int {
    n := len(grid)
    found := false
    for i := 0; i < n && !found; i++ {
        for j := 0; j < n && !found; j++ {
            if grid[i][j] == 1 {
                dfs(grid, i, j)
                found = true
            }
        }
    }

    queue := [][]int{}
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 2 {
                queue = append(queue, []int{i, j})
            }
        }
    }

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            for _, dir := range directions {
                x, y := cell[0]+dir[0], cell[1]+dir[1]
                if x >= 0 && x < n && y >= 0 && y < n {
                    if grid[x][y] == 1 {
                        return 0
                    }
                    if grid[x][y] == 0 {
                        grid[x][y] = 2
                        queue = append(queue, []int{x, y})
                    }
                }
            }
        }
    }
    return 0
}

func dfs(grid [][]int, i, j int) {
    if i < 0 || j < 0 || i >= len(grid) || j >= len(grid) || grid[i][j] != 1 {
        return
    }
    grid[i][j] = 2
    dfs(grid, i+1, j)
    dfs(grid, i-1, j)
    dfs(grid, i, j+1)
    dfs(grid, i, j-1)
}