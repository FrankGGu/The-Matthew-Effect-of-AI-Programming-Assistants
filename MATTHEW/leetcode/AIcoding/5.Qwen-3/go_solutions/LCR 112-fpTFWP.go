package main

func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }
    rows, cols := len(matrix), len(matrix[0])
    memo := make([][]int, rows)
    for i := range memo {
        memo[i] = make([]int, cols)
    }
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if memo[i][j] != 0 {
            return memo[i][j]
        }
        maxPath := 1
        for _, d := range directions {
            ni, nj := i+d[0], j+d[1]
            if ni >= 0 && ni < rows && nj >= 0 && nj < cols && matrix[ni][nj] > matrix[i][j] {
                current := 1 + dfs(ni, nj)
                if current > maxPath {
                    maxPath = current
                }
            }
        }
        memo[i][j] = maxPath
        return maxPath
    }
    result := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            result = max(result, dfs(i, j))
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}