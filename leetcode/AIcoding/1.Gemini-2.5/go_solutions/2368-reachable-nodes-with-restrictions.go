func reachableNodes(n int, edges [][]int, restricted []int) int {
    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    isRestricted := make([]bool, n)
    for _, node := range restricted {
        isRestricted[node] = true
    }

    if isRestricted[0] {
        return 0 // Node 0 is restricted, but problem statement says "0 is not restricted", so this check might be redundant based on problem constraints.
    }

    queue := []int{0}
    visited := make([]bool, n)
    visited[0] = true

    reachableCount := 0

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        reachableCount++

        for _, neighbor := range adj[node] {
            if !visited[neighbor] && !isRestricted[neighbor] {
                visited[neighbor] = true
                queue = append(queue, neighbor)
            }
        }
    }

    return reachableCount
}