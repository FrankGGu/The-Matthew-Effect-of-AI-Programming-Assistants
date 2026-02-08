func minTrioDegree(n int, edges [][]int) int {
    adj := make([][]bool, n+1)
    degree := make([]int, n+1)
    for i := range adj {
        adj[i] = make([]bool, n+1)
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u][v] = true
        adj[v][u] = true
        degree[u]++
        degree[v]++
    }

    minDegree := math.MaxInt32
    for i := 1; i <= n; i++ {
        for j := i+1; j <= n; j++ {
            if adj[i][j] {
                for k := j+1; k <= n; k++ {
                    if adj[i][k] && adj[j][k] {
                        currentDegree := degree[i] + degree[j] + degree[k] - 6
                        if currentDegree < minDegree {
                            minDegree = currentDegree
                        }
                    }
                }
            }
        }
    }

    if minDegree == math.MaxInt32 {
        return -1
    }
    return minDegree
}