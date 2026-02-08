package main

func validPath(n int, graph [][]int, source int, destination int) bool {
    visited := make([]bool, n)
    queue := []int{source}
    visited[source] = true

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if node == destination {
            return true
        }
        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, neighbor)
            }
        }
    }

    return false
}