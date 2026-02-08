func minCost(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = 100000
        }
    }
    dist[0][0] = 0
    q := [][]int{{0, 0}}
    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for len(q) > 0 {
        curr := q[0]
        q = q[1:]
        r, c := curr[0], curr[1]

        for i := 0; i < 4; i++ {
            nr, nc := r+dirs[i][0], c+dirs[i][1]
            cost := 0
            if i+1 != grid[r][c] {
                cost = 1
            }
            if nr >= 0 && nr < m && nc >= 0 && nc < n {
                if dist[r][c]+cost < dist[nr][nc] {
                    dist[nr][nc] = dist[r][c] + cost
                    if cost == 0 {
                        q = append([][]int{{nr, nc}}, q...)
                    } else {
                        q = append(q, []int{nr, nc})
                    }
                }
            }
        }
    }

    return dist[m-1][n-1]
}