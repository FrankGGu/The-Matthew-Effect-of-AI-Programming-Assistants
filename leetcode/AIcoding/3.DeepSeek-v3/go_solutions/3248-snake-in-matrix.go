func findSnake(matrix [][]int) []int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return []int{}
    }

    m, n := len(matrix), len(matrix[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    var path []int
    var dfs func(i, j int, current []int) bool
    dfs = func(i, j int, current []int) bool {
        if len(current) == m*n {
            path = make([]int, len(current))
            copy(path, current)
            return true
        }

        for _, dir := range directions {
            ni, nj := i + dir[0], j + dir[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj] {
                if len(current) == 0 || (matrix[ni][nj] == matrix[i][j] + 1 || matrix[ni][nj] == matrix[i][j] - 1) {
                    visited[ni][nj] = true
                    current = append(current, matrix[ni][nj])
                    if dfs(ni, nj, current) {
                        return true
                    }
                    current = current[:len(current)-1]
                    visited[ni][nj] = false
                }
            }
        }
        return false
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            visited[i][j] = true
            if dfs(i, j, []int{matrix[i][j]}) {
                return path
            }
            visited[i][j] = false
        }
    }

    return []int{}
}