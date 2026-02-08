package main

func minimumObstaclesToRemove(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = 1 << 30
        }
    }
    dist[0][0] = 0
    pq := [][]int{{0, 0, 0}}
    for len(pq) > 0 {
        node := pq[0]
        pq = pq[1:]
        d, x, y := node[0], node[1], node[2]
        if x == m-1 && y == n-1 {
            return d
        }
        if d > dist[x][y] {
            continue
        }
        for _, dir := range dirs {
            nx, ny := x+dir[0], y+dir[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n {
                newD := d + grid[nx][ny]
                if newD < dist[nx][ny] {
                    dist[nx][ny] = newD
                    pq = append(pq, []int{newD, nx, ny})
                }
            }
        }
    }
    return dist[m-1][n-1]
}