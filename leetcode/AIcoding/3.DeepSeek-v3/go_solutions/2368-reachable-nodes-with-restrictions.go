func reachableNodes(n int, edges [][]int, restricted []int) int {
    restrictedSet := make(map[int]bool)
    for _, node := range restricted {
        restrictedSet[node] = true
    }

    graph := make(map[int][]int)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if !restrictedSet[u] && !restrictedSet[v] {
            graph[u] = append(graph[u], v)
            graph[v] = append(graph[v], u)
        }
    }

    visited := make(map[int]bool)
    queue := []int{0}
    visited[0] = true
    count := 0

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        count++

        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, neighbor)
            }
        }
    }

    return count
}