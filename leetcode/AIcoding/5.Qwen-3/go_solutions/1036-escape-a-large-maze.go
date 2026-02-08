package main

func isEscapePossible(target [][]int, grid [][]int) bool {
    dirs := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    m, n := len(grid), len(grid[0])

    var bfs func(start []int, end []int, visited map[[2]int]bool) bool
    bfs = func(start []int, end []int, visited map[[2]int]bool) bool {
        q := [][2]int{[2]int{start[0], start[1]}}
        visited[[2]int{start[0], start[1]}] = true
        for len(q) > 0 {
            size := len(q)
            for i := 0; i < size; i++ {
                pos := q[i]
                if pos[0] == end[0] && pos[1] == end[1] {
                    return true
                }
                for _, d := range dirs {
                    nx, ny := pos[0]+d[0], pos[1]+d[1]
                    if nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[[2]int{nx, ny}] && grid[nx][ny] == 0 {
                        visited[[2]int{nx, ny}] = true
                        q = append(q, [2]int{nx, ny})
                    }
                }
            }
            q = q[size:]
        }
        return false
    }

    visited1 := make(map[[2]int]bool)
    if !bfs([]int{0, 0}, target[0], visited1) {
        return false
    }

    visited2 := make(map[[2]int]bool)
    if !bfs(target[0], []int{0, 0}, visited2) {
        return false
    }

    return true
}