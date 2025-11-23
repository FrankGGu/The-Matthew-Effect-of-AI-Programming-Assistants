func countSubtrees(n int, edges [][]int, distanceThreshold int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    count := 0
    for i := 0; i < n; i++ {
        count += dfs(i, -1, 0, distanceThreshold, graph)
    }
    return count
}

func dfs(node, parent, distance, distanceThreshold int, graph [][]int) int {
    if distance > distanceThreshold {
        return 0
    }
    total := 1
    for _, neighbor := range graph[node] {
        if neighbor != parent {
            total += dfs(neighbor, node, distance+1, distanceThreshold, graph)
        }
    }
    return total
}