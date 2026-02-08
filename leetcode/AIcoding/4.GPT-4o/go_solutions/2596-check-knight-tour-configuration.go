func checkValidGrid(grid [][]int) bool {
    n := len(grid)
    if n == 0 || n != len(grid[0]) {
        return false
    }
    visited := make([]bool, n*n)
    directions := []struct{ dx, dy int }{
        {2, 1}, {1, 2}, {-1, 2}, {-2, 1},
        {-2, -1}, {-1, -2}, {1, -2}, {2, -1},
    }

    currX, currY := 0, 0
    for i := 0; i < n*n; i++ {
        if grid[currX][currY] != i {
            return false
        }
        visited[i] = true

        nextX, nextY := -1, -1
        for _, d := range directions {
            nx, ny := currX + d.dx, currY + d.dy
            if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[grid[nx][ny]] {
                if nextX == -1 {
                    nextX, nextY = nx, ny
                }
            }
        }

        if nextX == -1 {
            return i == n*n-1
        }
        currX, currY = nextX, nextY
    }
    return true
}