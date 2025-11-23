func updateMatrix(mat [][]int) [][]int {
    m, n := len(mat), len(mat[0])
    dist := make([][]int, m)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            if mat[i][j] == 0 {
                dist[i][j] = 0
            } else {
                dist[i][j] = math.MaxInt32
            }
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if i > 0 {
                dist[i][j] = min(dist[i][j], dist[i-1][j]+1)
            }
            if j > 0 {
                dist[i][j] = min(dist[i][j], dist[i][j-1]+1)
            }
        }
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if i < m-1 {
                dist[i][j] = min(dist[i][j], dist[i+1][j]+1)
            }
            if j < n-1 {
                dist[i][j] = min(dist[i][j], dist[i][j+1]+1)
            }
        }
    }

    return dist
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}