package main

func possibleBipartition(n int, dislikes [][]int) bool {
    graph := make([][]int, n+1)
    for _, d := range dislikes {
        graph[d[0]] = append(graph[d[0]], d[1])
        graph[d[1]] = append(graph[d[1]], d[0])
    }

    color := make([]int, n+1)

    var dfs func(int, int) bool
    dfs = func(node int, c int) bool {
        if color[node] != 0 {
            return color[node] == c
        }
        color[node] = c
        for _, neighbor := range graph[node] {
            if !dfs(neighbor, -c) {
                return false
            }
        }
        return true
    }

    for i := 1; i <= n; i++ {
        if color[i] == 0 && !dfs(i, 1) {
            return false
        }
    }
    return true
}