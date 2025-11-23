func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }
    m, n := len(matrix), len(matrix[0])
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    memo := make([][]int, m)
    for i := range memo {
        memo[i] = make([]int, n)
    }
    maxLen := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            length := dfs(matrix, i, j, m, n, dirs, memo)
            if length > maxLen {
                maxLen = length
            }
        }
    }
    return maxLen
}

func dfs(matrix [][]int, i, j, m, n int, dirs [][]int, memo [][]int) int {
    if memo[i][j] != 0 {
        return memo[i][j]
    }
    max := 1
    for _, dir := range dirs {
        x, y := i+dir[0], j+dir[1]
        if x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j] {
            length := 1 + dfs(matrix, x, y, m, n, dirs, memo)
            if length > max {
                max = length
            }
        }
    }
    memo[i][j] = max
    return max
}