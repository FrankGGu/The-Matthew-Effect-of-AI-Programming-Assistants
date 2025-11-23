func isBipartite(graph [][]int) bool {
    n := len(graph)
    color := make([]int, n)

    for i := 0; i < n; i++ {
        if color[i] == 0 {
            queue := []int{i}
            color[i] = 1
            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]
                for _, neighbor := range graph[node] {
                    if color[neighbor] == 0 {
                        color[neighbor] = -color[node]
                        queue = append(queue, neighbor)
                    } else if color[neighbor] == color[node] {
                        return false
                    }
                }
            }
        }
    }
    return true
}