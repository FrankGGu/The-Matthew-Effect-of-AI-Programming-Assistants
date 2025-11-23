func validPath(n int, edges [][]int, source int, destination int) bool {
    if source == destination {
        return true
    }

    graph := make(map[int][]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make(map[int]bool)
    queue := []int{source}
    visited[source] = true

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]

        for _, neighbor := range graph[node] {
            if neighbor == destination {
                return true
            }
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, neighbor)
            }
        }
    }

    return false
}