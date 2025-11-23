func shortestPath(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    if m == 0 || n == 0 {
        return -1
    }

    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    queue := [][]int{{0, 0, 0, k}} // x, y, steps, remaining k
    visited := make(map[[3]int]bool)
    visited[[3]int{0, 0, k}] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        x, y, steps, remainingK := current[0], current[1], current[2], current[3]

        if x == m-1 && y == n-1 {
            return steps
        }

        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && ny >= 0 && nx < m && ny < n {
                newRemainingK := remainingK - grid[nx][ny]
                if newRemainingK >= 0 && !visited[[3]int{nx, ny, newRemainingK}] {
                    visited[[3]int{nx, ny, newRemainingK}] = true
                    queue = append(queue, []int{nx, ny, steps + 1, newRemainingK})
                }
            }
        }
    }

    return -1
}