func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }
    m, n := len(matrix), len(matrix[0])
    memo := make([][]int, m)
    for i := range memo {
        memo[i] = make([]int, n)
    }
    maxLen := 0
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if memo[i][j] != 0 {
            return memo[i][j]
        }
        max := 1
        for _, dir := range directions {
            x, y := i + dir[0], j + dir[1]
            if x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j] {
                length := 1 + dfs(x, y)
                if length > max {
                    max = length
                }
            }
        }
        memo[i][j] = max
        return max
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            path := dfs(i, j)
            if path > maxLen {
                maxLen = path
            }
        }
    }
    return maxLen
}