func possibleBipartition(n int, dislikes [][]int) bool {
    graph := make([][]int, n+1)
    for _, d := range dislikes {
        a, b := d[0], d[1]
        graph[a] = append(graph[a], b)
        graph[b] = append(graph[b], a)
    }

    color := make([]int, n+1)

    for i := 1; i <= n; i++ {
        if color[i] == 0 {
            queue := []int{i}
            color[i] = 1
            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]
                for _, neighbor := range graph[node] {
                    if color[neighbor] == color[node] {
                        return false
                    }
                    if color[neighbor] == 0 {
                        color[neighbor] = -color[node]
                        queue = append(queue, neighbor)
                    }
                }
            }
        }
    }
    return true
}