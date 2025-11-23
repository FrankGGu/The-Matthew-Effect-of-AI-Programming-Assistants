package main

func guardCastle(n int, m int, k int, grid [][]byte) int {
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, m)
    }
    queue := [][2]int{}
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 'G' {
                queue = append(queue, [2]int{i, j})
                visited[i][j] = true
            }
        }
    }
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            for _, d := range directions {
                ni, nj := current[0]+d[0], current[1]+d[1]
                if ni >= 0 && ni < n && nj >= 0 && nj < m && !visited[ni][nj] && grid[ni][nj] != 'X' {
                    visited[ni][nj] = true
                    queue = append(queue, [2]int{ni, nj})
                }
            }
        }
    }
    result := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 'T' && !visited[i][j] {
                result++
            }
        }
    }
    return result
}