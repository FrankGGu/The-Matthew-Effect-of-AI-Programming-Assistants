package main

func longestCycle(n int, edges [][]int) int {
    graph := make(map[int][]int)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
    }

    visited := make([]bool, n)
    result := -1

    for i := 0; i < n; i++ {
        if !visited[i] {
            seen := make(map[int]int)
            queue := []int{i}
            seen[i] = 0
            visited[i] = true

            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]

                for _, neighbor := range graph[node] {
                    if _, ok := seen[neighbor]; ok {
                        if seen[neighbor] != -1 {
                            result = max(result, seen[node]-seen[neighbor]+1)
                        }
                    } else if !visited[neighbor] {
                        visited[neighbor] = true
                        seen[neighbor] = seen[node] + 1
                        queue = append(queue, neighbor)
                    } else {
                        seen[neighbor] = -1
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