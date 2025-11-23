func gardenNoAdj(n int, paths [][]int) []int {
    graph := make([][]int, n+1)
    for _, path := range paths {
        u, v := path[0], path[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    colors := make([]int, n+1)
    for i := 1; i <= n; i++ {
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

    return colors[1:]
}