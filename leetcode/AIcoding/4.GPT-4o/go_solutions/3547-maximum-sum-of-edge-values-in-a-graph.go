func maximumSumEdgeValues(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    maxSum := 0
    for u := 0; u < n; u++ {
        for _, v := range graph[u] {
            sum := u + v
            if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}