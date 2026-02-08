func frogPosition(n int, edges [][]int, t int, target int) float64 {
    graph := make(map[int][]int)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    visited := make([]bool, n+1)
    var dfs func(node, time int) float64
    dfs = func(node, time int) float64 {
        if time < 0 || visited[node] {
            return 0.0
        }
        visited[node] = true

        if node == target {
            if time == 0 {
                return 1.0
            }
            neighbors := len(graph[node])
            if neighbors == 1 && node != 1 {
                return 1.0
            }
            prob := 0.0
            for _, neighbor := range graph[node] {
                if !visited[neighbor] {
                    prob += dfs(neighbor, time-1) / float64(neighbors)
                }
            }
            return prob
        }

        return 0.0
    }

    return dfs(1, t)
}