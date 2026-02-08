func pacificAtlantic(heights [][]int) [][]int {
    if len(heights) == 0 || len(heights[0]) == 0 {
        return [][]int{}
    }

    rows, cols := len(heights), len(heights[0])
    pacific := make([][]bool, rows)
    atlantic := make([][]bool, rows)
    for i := range pacific {
        pacific[i] = make([]bool, cols)
        atlantic[i] = make([]bool, cols)
    }

    var dfs func(r, c int, visited [][]bool)
    dfs = func(r, c int, visited [][]bool) {
        if visited[r][c] {
            return
        }
        visited[r][c] = true
        directions := []struct{ r, c int }{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
        for _, dir := range directions {
            nr, nc := r+dir.r, c+dir.c
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && heights[nr][nc] >= heights[r][c] {
                dfs(nr, nc, visited)
            }
        }
    }

    for r := 0; r < rows; r++ {
        dfs(r, 0, pacific)
        dfs(r, cols-1, atlantic)
    }
    for c := 0; c < cols; c++ {
        dfs(0, c, pacific)
        dfs(rows-1, c, atlantic)
    }

    result := [][]int{}
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if pacific[r][c] && atlantic[r][c] {
                result = append(result, []int{r, c})
            }
        }
    }
    return result
}