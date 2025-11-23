func findSafePath(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    if grid[0][0] == 1 || grid[m-1][n-1] == 1 {
        return -1
    }

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}}
    queue := [][]int{{0, 0, 1}}
    grid[0][0] = 1

    for len(queue) > 0 {
        cell := queue[0]
        queue = queue[1:]
        x, y, dist := cell[0], cell[1], cell[2]

        if x == m-1 && y == n-1 {
            return dist
        }

        for _, dir := range directions {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0 {
                safe := true
                for _, check := range directions {
                    cx, cy := nx+check[0], ny+check[1]
                    if cx >= 0 && cx < m && cy >= 0 && cy < n && grid[cx][cy] == 1 {
                        safe = false
                        break
                    }
                }
                if safe {
                    grid[nx][ny] = 1
                    queue = append(queue, []int{nx, ny, dist + 1})
                }
            }
        }
    }

    return -1
}