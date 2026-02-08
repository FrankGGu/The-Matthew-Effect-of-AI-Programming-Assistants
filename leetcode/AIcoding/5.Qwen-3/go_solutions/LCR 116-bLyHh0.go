package main

func findCircleNum(isConnected [][]int) int {
    n := len(isConnected)
    visited := make([]bool, n)

    var dfs func(int)
    dfs = func(i int) {
        for j := 0; j < n; j++ {
            if isConnected[i][j] == 1 && !visited[j] {
                visited[j] = true
                dfs(j)
            }
        }
    }

    count := 0
    for i := 0; i < n; i++ {
        if !visited[i] {
            visited[i] = true
            dfs(i)
            count++
        }
    }

    return count
}