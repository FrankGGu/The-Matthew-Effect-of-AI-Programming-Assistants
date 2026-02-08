func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows := len(matrix)
    cols := len(matrix[0])
    memo := make([][]int, rows)
    for i := range memo {
        memo[i] = make([]int, cols)
    }

    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if memo[r][c] != 0 {
            return memo[r][c]
        }

        maxLen := 1 // Minimum path length is 1 (the cell itself)

        for _, dir := range dirs {
            nr, nc := r+dir[0], c+dir[1]

            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c] {
                currentPathLen := 1 + dfs(nr, nc)
                if currentPathLen > maxLen {
                    maxLen = currentPathLen
                }
            }
        }

        memo[r][c] = maxLen
        return maxLen
    }

    overallMaxLen := 0
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            currentPath := dfs