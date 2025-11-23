package main

func findCircleNum(isConnected [][]int) int {
    n := len(isConnected)
    visited := make([]bool, n)
    provinces := 0

    var dfs func(int)
    dfs = func(node int) {
        for i := 0; i < n; i++ {
            if isConnected[node][i] == 1 && !visited[i] {
                visited[i] = true
                dfs(i)
            }
        }
    }

    for i := 0; i < n; i++ {
        if !visited[i] {
            provinces++
            visited[i] = true
            dfs(i)
        }
    }

    return provinces
}