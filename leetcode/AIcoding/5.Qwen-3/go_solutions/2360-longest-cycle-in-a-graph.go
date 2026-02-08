package main

func longestCycle(n int, edges [][]int) int {
    graph := make([][]int, n)
    for _, e := range edges {
        graph[e[0]] = append(graph[e[0]], e[1])
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
                            result = max(result, dist[node]+1-dist[neighbor])
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