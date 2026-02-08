func minimumTimeToBreakLocks(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    queue := [][]int{}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                queue = append(queue, []int{i, j, 0})
                visited[i][j] = true
            }
        }
    }

    time := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[i]
            x, y, t := cell[0], cell[1], cell[2]
            time = max(time, t)
            for _, dir := range dirs {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] == 1 {
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny, t + 1})
                }
            }
        }
        queue = queue[size:]
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 && !visited[i][j] {
                return -1
            }
        }
    }
    return time
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}