func minimumMoves(grid [][]int) int {
    n, m := len(grid), len(grid[0])
    directions := [][2]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, m)
    }

    var bfs func() int
    bfs = func() int {
        queue := [][]int{{0, 0, 0}}
        visited[0][0] = true
        for len(queue) > 0 {
            x, y, moves := queue[0][0], queue[0][1], queue[0][2]
            queue = queue[1:]

            if x == n-1 && y == m-1 {
                return moves
            }

            for _, dir := range directions {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny] && grid[nx][ny] == 0 {
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny, moves + 1})
                }
            }
        }
        return -1
    }

    return bfs()
}