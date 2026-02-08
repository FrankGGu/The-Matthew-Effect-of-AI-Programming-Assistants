func gardenNoAdj(N int, paths [][]int) []int {
    graph := make([][]int, N)
    for _, path := range paths {
        graph[path[0]-1] = append(graph[path[0]-1], path[1]-1)
        graph[path[1]-1] = append(graph[path[1]-1], path[0]-1)
    }

    colors := make([]int, N)
    for i := 0; i < N; i++ {
        used := make([]bool, 5)
        for _, neighbor := range graph[i] {
            used[colors[neighbor]] = true
        }
        for c := 1; c <= 4; c++ {
            if !used[c] {
                colors[i] = c
                break
            }
        }
    }
    return colors
}