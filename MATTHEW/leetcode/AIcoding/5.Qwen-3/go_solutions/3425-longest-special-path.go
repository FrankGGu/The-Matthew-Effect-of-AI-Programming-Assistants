package main

func longestCycle(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
    }

    visited := make([]bool, n)
    result := -1

    for i := 0; i < n; i++ {
        if !visited[i] {
            parent := make([]int, n)
            dist := make([]int, n)
            queue := []int{i}
            visited[i] = true
            parent[i] = -1

            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]

                for _, neighbor := range graph[node] {
                    if !visited[neighbor] {
                        visited[neighbor] = true
                        parent[neighbor] = node
                        dist[neighbor] = dist[node] + 1
                        queue = append(queue, neighbor)
                    } else if parent[node] != neighbor {
                        if dist[neighbor] != 0 {
                            result = max(result, dist[node]+1)
                        }
                    }
                }
            }
        }
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}