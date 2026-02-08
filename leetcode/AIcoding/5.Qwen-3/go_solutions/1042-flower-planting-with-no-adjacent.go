package main

func gardenNoAdj(n int, paths [][]int) []int {
    graph := make([][]int, n)
    for _, path := range paths {
        a, b := path[0]-1, path[1]-1
        graph[a] = append(graph[a], b)
        graph[b] = append(graph[b], a)
    }

    result := make([]int, n)
    for i := 0; i < n; i++ {
        used := make([]bool, 5)
        for _, neighbor := range graph[i] {
            if result[neighbor] > 0 {
                used[result[neighbor]] = true
            }
        }
        for j := 1; j <= 4; j++ {
            if !used[j] {
                result[i] = j
                break
            }
        }
    }
    return result
}