package main

func minSeconds(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    var start, end [2]int
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                start = [2]int{i, j}
            }
            if grid[i][j] == 2 {
                end = [2]int{i, j}
            }
        }
    }

    directions := [][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    queue := [][3]int{{start[0], start[1], 0}}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    visited[start[0]][start[1]] = true

    for len(queue) > 0 {
        x, y, time := queue[0][0], queue[0][1], queue[0][2]
        queue = queue[1:]
        if x == end[0] && y == end[1] {
            return time
        }
        for _, d := range directions {
            nx, ny := x+d[0], y+d[1]
            if nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && grid[nx][ny] != 0 {
                visited[nx][ny] = true
                queue = append(queue, [3]int{nx, ny, time + 1})
            }
        }
    }
    return -1
}