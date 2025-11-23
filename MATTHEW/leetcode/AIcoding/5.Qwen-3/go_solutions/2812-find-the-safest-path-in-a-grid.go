package main

func maxDistance(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    q := [][]int{}
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                q = append(q, []int{i, j})
            }
        }
    }
    if len(q) == 0 || len(q) == n*m {
        return -1
    }
    dist := make([][]int, n)
    for i := 0; i < n; i++ {
        dist[i] = make([]int, m)
        for j := 0; j < m; j++ {
            dist[i][j] = -1
        }
    }
    for _, pos := range q {
        dist[pos[0]][pos[1]] = 0
    }
    for len(q) > 0 {
        curr := q[0]
        q = q[1:]
        for _, d := range dirs {
            x, y := curr[0]+d[0], curr[1]+d[1]
            if x >= 0 && x < n && y >= 0 && y < m && dist[x][y] == -1 {
                dist[x][y] = dist[curr[0]][curr[1]] + 1
                q = append(q, []int{x, y})
            }
        }
    }
    maxDist := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if dist[i][j] > maxDist {
                maxDist = dist[i][j]
            }
        }
    }
    return maxDist
}