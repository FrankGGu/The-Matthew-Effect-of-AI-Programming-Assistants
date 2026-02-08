package main

func minTimeToVisitAllNodes(graph [][]int, start int, end int) int {
    visited := make([]bool, len(graph))
    queue := [][2]int{{start, 0}}
    visited[start] = true

    for len(queue) > 0 {
        node, time := queue[0][0], queue[0][1]
        queue = queue[1:]

        if node == end {
            return time
        }

        for _, neighbor := range graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue = append(queue, [2]int{neighbor, time + 1})
            }
        }
    }

    return -1
}