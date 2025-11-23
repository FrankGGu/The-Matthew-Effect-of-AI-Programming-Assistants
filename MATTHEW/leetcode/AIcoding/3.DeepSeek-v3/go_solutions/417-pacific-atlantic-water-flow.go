func pacificAtlantic(matrix [][]int) [][]int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return [][]int{}
    }

    m, n := len(matrix), len(matrix[0])
    pacific := make([][]bool, m)
    atlantic := make([][]bool, m)
    for i := 0; i < m; i++ {
        pacific[i] = make([]bool, n)
        atlantic[i] = make([]bool, n)
    }

    for i := 0; i < m; i++ {
        dfs(matrix, pacific, i, 0, m, n)
        dfs(matrix, atlantic, i, n-1, m, n)
    }

    for j := 0; j < n; j++ {
        dfs(matrix, pacific, 0, j, m, n)
        dfs(matrix, atlantic, m-1, j, m, n)
    }

    var res [][]int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if pacific[i][j] && atlantic[i][j] {
                res = append(res, []int{i, j})
            }
        }
    }

    return res
}

func dfs(matrix [][]int, visited [][]bool, i, j, m, n int) {
    if visited[i][j] {
        return
    }

    visited[i][j] = true
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for _, dir := range dirs {
        x, y := i + dir[0], j + dir[1]
        if x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] >= matrix[i][j] {
            dfs(matrix, visited, x, y, m, n)
        }
    }
}