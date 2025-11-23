func isBipartite(graph [][]int) bool {
    n := len(graph)
    colors := make([]int, n)

    for i := 0; i < n; i++ {
        if colors[i] == 0 {
            queue := []int{i}
            colors[i] = 1
            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]
                for _, neighbor := range graph[node] {
                    if colors[neighbor] == 0 {
                        colors[neighbor] = -colors[node]
                        queue = append(queue, neighbor)
                    } else if colors[neighbor] == colors[node] {
                        return false
                    }
                }
            }
        }
    }
    return true
}