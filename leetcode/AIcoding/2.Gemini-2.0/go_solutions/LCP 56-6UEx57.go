func conveyorBelt(matrix []string, start []int, end []int) int {
    m, n := len(matrix), len(matrix[0])
    q := [][]int{{start[0], start[1], 0}}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    visited[start[0]][start[1]] = true

    dx := []int{0, 0, 1, -1}
    dy := []int{1, -1, 0, 0}
    symbols := []byte{'>', '<', 'v', '^'}

    for len(q) > 0 {
        curr := q[0]
        q = q[1:]
        x, y, steps := curr[0], curr[1], curr[2]

        if x == end[0] && y == end[1] {
            return steps
        }

        for i := 0; i < 4; i++ {
            nx, ny := x+dx[i], y+dy[i]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] {
                visited[nx][ny] = true
                cost := steps
                if matrix[x][y] != symbols[i] {
                    cost++
                }
                q = append(q, []int{nx, ny, cost})
            }
        }
    }

    return -1
}