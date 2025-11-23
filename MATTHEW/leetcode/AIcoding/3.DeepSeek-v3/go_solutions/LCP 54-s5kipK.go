func minimumOperations(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    q := [][]int{}
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            if grid[i][j] == 1 {
                q = append(q, []int{i, j})
                dist[i][j] = 0
            } else {
                dist[i][j] = -1
            }
        }
    }

    for len(q) > 0 {
        cur := q[0]
        q = q[1:]
        x, y := cur[0], cur[1]
        for _, d := range dirs {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && dist[nx][ny] == -1 {
                dist[nx][ny] = dist[x][y] + 1
                q = append(q, []int{nx, ny})
            }
        }
    }

    maxDist := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 2 && dist[i][j] > maxDist {
                maxDist = dist[i][j]
            }
        }
    }

    if maxDist == 0 {
        return -1
    }
    return maxDist
}