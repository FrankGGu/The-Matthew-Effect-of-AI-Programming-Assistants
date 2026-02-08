type state struct {
    x, y, k int
}

func shortestPath(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    if m == 1 && n == 1 {
        return 0
    }

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make(map[state]bool)
    q := []state{{0, 0, k}}
    visited[state{0, 0, k}] = true
    steps := 0

    for len(q) > 0 {
        size := len(q)
        for i := 0; i < size; i++ {
            curr := q[0]
            q = q[1:]
            for _, dir := range dirs {
                nx, ny := curr.x + dir[0], curr.y + dir[1]
                if nx >= 0 && nx < m && ny >= 0 && ny < n {
                    if nx == m-1 && ny == n-1 {
                        return steps + 1
                    }
                    newK := curr.k
                    if grid[nx][ny] == 1 {
                        newK--
                    }
                    if newK >= 0 {
                        newState := state{nx, ny, newK}
                        if !visited[newState] {
                            visited[newState] = true
                            q = append(q, newState)
                        }
                    }
                }
            }
        }
        steps++
    }
    return -1
}