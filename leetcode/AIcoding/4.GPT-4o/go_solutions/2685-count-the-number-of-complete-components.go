func countCompleteComponents(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n)
    var dfs func(int) (int, int)
    dfs = func(node int) (int, int) {
        visited[node] = true
        count := 1
        edgeCount := 0
        for _, neighbor := range graph[node] {
            edgeCount++
            if !visited[neighbor] {
                subCount, subEdges := dfs(neighbor)
                count += subCount
                edgeCount += subEdges
            }
        }
        return count, edgeCount
    }

    completeCount := 0
    for i := 0; i < n; i++ {
        if !visited[i] {
            nodeCount, edgeCount := dfs(i)
            if edgeCount == nodeCount*(nodeCount-1) {
                completeCount++
            }
        }
    }

    return completeCount
}