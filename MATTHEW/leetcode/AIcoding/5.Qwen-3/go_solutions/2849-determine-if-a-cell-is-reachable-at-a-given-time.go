package main

func isReachable(grid [][]int, time int) bool {
    m, n := len(grid), len(grid[0])
    queue := [][2]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                queue = append(queue, [2]int{i, j})
            }
        }
    }
    directions := [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            if grid[cell[0]][cell[1]] == 2 {
                return true
            }
            for _, dir := range directions {
                ni, nj := cell[0]+dir[0], cell[1]+dir[1]
                if ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] == 0 {
                    grid[ni][nj] = grid[cell[0]][cell[1]] + 1
                    queue = append(queue, [2]int{ni, nj})
                }
            }
        }
        time--
        if time < 0 {
            return false
        }
    }
    return false
}