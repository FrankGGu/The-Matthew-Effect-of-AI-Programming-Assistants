func minTrioDegree(n int, edges [][]int) int {
    adj := make([][]bool, n)
    degree := make([]int, n)
    for i := range adj {
        adj[i] = make([]bool, n)
    }
    for _, edge := range edges {
        u, v := edge[0]-1, edge[1]-1
        adj[u][v] = true
        adj[v][u] = true
        degree[u]++
        degree[v]++
    }
    minDegree := int(1e9)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if adj[i][j] {
                for k := j + 1; k < n; k++ {
                    if adj[i][k] && adj[j][k] {
                        trioDegree := degree[i] + degree[j] + degree[k] - 6
                        if trioDegree < minDegree {
                            minDegree = trioDegree
                        }
                    }
                }
            }
        }
    }
    if minDegree == int(1e9) {
        return -1
    }
    return minDegree
}