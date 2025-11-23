func minTrioDegree(n int, edges [][]int) int {
    degree := make([]int, n+1)
    graph := make([][]int, n+1)

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
        degree[u]++
        degree[v]++
    }

    minDegree := math.MaxInt32

    for u := 1; u <= n; u++ {
        for i := 0; i < len(graph[u]); i++ {
            for j := i + 1; j < len(graph[u]); j++ {
                v, w := graph[u][i], graph[u][j]
                if v > w {
                    v, w = w, v
                }
                if contains(graph[v], w) {
                    currentDegree := degree[u] + degree[v] + degree[w] - 6
                    if currentDegree < minDegree {
                        minDegree = currentDegree
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

func contains(arr []int, target int) bool {
    for _, num := range arr {
        if num == target {
            return true
        }
    }
    return false
}