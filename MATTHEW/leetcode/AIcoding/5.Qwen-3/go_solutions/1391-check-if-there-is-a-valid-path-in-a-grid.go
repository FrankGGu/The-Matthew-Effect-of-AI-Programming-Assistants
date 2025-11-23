package main

func hasValidPath(grid [][]int) bool {
    rows, cols := len(grid), len(grid[0])
    directions := map[int][][2]int{
        1: {[2]int{0, 1}, [2]int{0, -1}},
        2: {[2]int{1, 0}, [2]int{-1, 0}},
        3: {[2]int{0, 1}, [2]int{1, 0}},
        4: {[2]int{0, 1}, [2]int{-1, 0}},
        5: {[2]int{0, -1}, [2]int{1, 0}},
        6: {[2]int{0, -1}, [2]int{-1, 0}},
    }

    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(r, c int) bool
    dfs = func(r, c int) bool {
        if r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] {
            return false
        }
        if r == rows-1 && c == cols-1 {
            return true
        }
        visited[r][c] = true
        for _, dir := range directions[grid[r][c]] {
            nr, nc := r+dir[0], c+dir[1]
            if dfs(nr, nc) {
                return true
            }
        }
        return false
    }

    return dfs(0, 0)
}