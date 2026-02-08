func validPath(n int, edges [][]int, source int, destination int) bool {
    graph := make(map[int][]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    visited := make([]bool, n)
    queue := []int{source}
    visited[source] = true

    for len(queue) > 0 {
        curr := queue[0]
        queue = queue[1:]

        if curr == destination {
            return true
        }

        for _, neighbor := range graph[curr] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, neighbor)
            }
        }
    }

    return false
}