func findMinHeightTrees(n int, edges [][]int) []int {
    if n == 1 {
        return []int{0}
    }
    adj := make([][]int, n)
    degrees := make([]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
        degrees[u]++
        degrees[v]++
    }
    queue := []int{}
    for i := 0; i < n; i++ {
        if degrees[i] == 1 {
            queue = append(queue, i)
        }
    }
    remainingNodes := n
    for remainingNodes > 2 {
        size := len(queue)
        remainingNodes -= size
        for i := 0; i < size; i++ {
            node := queue[i]
            for _, neighbor := range adj[node] {
                degrees[neighbor]--
                if degrees[neighbor] == 1 {
                    queue = append(queue, neighbor)
                }
            }
        }
        queue = queue[size:]
    }
    return queue
}