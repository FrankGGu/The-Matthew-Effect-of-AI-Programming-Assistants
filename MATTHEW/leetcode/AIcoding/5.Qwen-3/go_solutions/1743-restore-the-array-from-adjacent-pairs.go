package main

func restoreArray(adjacentPairs [][]int) []int {
    graph := make(map[int][]int)
    for _, pair := range adjacentPairs {
        a, b := pair[0], pair[1]
        graph[a] = append(graph[a], b)
        graph[b] = append(graph[b], a)
    }

    var start int
    for k, v := range graph {
        if len(v) == 1 {
            start = k
            break
        }
    }

    result := make([]int, len(adjacentPairs)+1)
    result[0] = start
    visited := make(map[int]bool)
    visited[start] = true

    for i := 1; i < len(result); i++ {
        for _, neighbor := range graph[result[i-1]] {
            if !visited[neighbor] {
                result[i] = neighbor
                visited[neighbor] = true
                break
            }
        }
    }

    return result
}