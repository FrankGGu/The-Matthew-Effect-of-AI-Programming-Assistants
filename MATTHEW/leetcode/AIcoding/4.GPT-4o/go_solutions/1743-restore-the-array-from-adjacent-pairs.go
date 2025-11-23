func restoreArray(adjacentPairs [][]int) []int {
    graph := make(map[int][]int)
    for _, pair := range adjacentPairs {
        graph[pair[0]] = append(graph[pair[0]], pair[1])
        graph[pair[1]] = append(graph[pair[1]], pair[0])
    }

    result := []int{}
    visited := make(map[int]bool)
    var dfs func(node int)

    dfs = func(node int) {
        visited[node] = true
        result = append(result, node)
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                dfs(neighbor)
            }
        }
    }

    for node := range graph {
        dfs(node)
        break
    }

    return result
}