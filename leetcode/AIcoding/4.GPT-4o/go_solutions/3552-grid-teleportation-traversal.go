func gridTeleportationTraversal(grid [][]int) int {
    if len(grid) == 0 || len(grid[0]) == 0 {
        return 0
    }

    rows, cols := len(grid), len(grid[0])
    directions := []struct{ dx, dy int }{
        {0, 1}, {1, 0}, {0, -1}, {-1, 0},
    }

    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var bfs func(x, y int) int
    bfs = func(x, y int) int {
        queue := []struct{ x, y int }{{x, y}}
        visited[x][y] = true
        count := 0
        for len(queue) > 0 {
            count++
            curr := queue[0]
            queue = queue[1:]
            for _, d := range directions {
                nx, ny := curr.x+d.dx, curr.y+d.dy
                if nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny] && grid[nx][ny] == 1 {
                    visited[nx][ny] = true
                    queue = append(queue, struct{ x, y int }{nx, ny})
                }
            }
        }
        return count
    }

    maxTeleportation := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 && !visited[i][j] {
                maxTeleportation = max(maxTeleportation, bfs(i, j))
            }
        }
    }

    return maxTeleportation
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}