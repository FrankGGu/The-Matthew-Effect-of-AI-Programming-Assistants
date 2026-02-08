package main

func minFlips(matrix [][]int) int {
    m, n := len(matrix), len(matrix[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i < 0 || j < 0 || i >= m || j >= n || visited[i][j] || matrix[i][j] == 0 {
            return 0
        }
        visited[i][j] = true
        return 1 + dfs(i+1, j) + dfs(i-1, j) + dfs(i, j+1) + dfs(i, j-1)
    }
    res := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if !visited[i][j] && matrix[i][j] == 1 {
                cnt := dfs(i, j)
                if cnt%2 == 1 {
                    res++
                }
            }
        }
    }
    return res
}