package main

func eventualSafeStates(graph [][]int) []int {
    n := len(graph)
    color := make([]int, n)

    var dfs func(int) bool
    dfs = func(node int) bool {
        if color[node] == 1 {
            return false
        }
        if color[node] == 2 {
            return true
        }
        color[node] = 1
        for _, neighbor := range graph[node] {
            if !dfs(neighbor) {
                return false
            }
        }
        color[node] = 2
        return true
    }

    result := make([]int, 0)
    for i := 0; i < n; i++ {
        if dfs(i) {
            result = append(result, i)
        }
    }
    return result
}