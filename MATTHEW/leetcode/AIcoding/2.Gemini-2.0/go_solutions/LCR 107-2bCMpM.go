func updateMatrix(mat [][]int) [][]int {
    m, n := len(mat), len(mat[0])
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = -1
        }
    }

    queue := []struct{ x, y int }{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] == 0 {
                dist[i][j] = 0
                queue = append(queue, struct{ x, y int }{i, j})
            }
        }
    }

    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]
        x, y := curr.x, curr.y

        for _, dir := range dirs {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && dist[nx][ny] == -1 {
                dist[nx][ny] = dist[x][y] + 1
                queue = append(queue, struct{ x, y int }{nx, ny})
            }
        }
    }

    return dist
}