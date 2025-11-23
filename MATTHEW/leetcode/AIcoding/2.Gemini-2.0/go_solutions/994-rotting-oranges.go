func orangesRotting(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    freshCount := 0
    queue := [][]int{}
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                freshCount++
            } else if grid[i][j] == 2 {
                queue = append(queue, []int{i, j})
            }
        }
    }

    minutes := 0
    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for len(queue) > 0 {
        size := len(queue)
        rottenThisMinute := false
        for i := 0; i < size; i++ {
            orange := queue[0]
            queue = queue[1:]
            row, col := orange[0], orange[1]

            for _, dir := range directions {
                newRow, newCol := row+dir[0], col+dir[1]

                if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1 {
                    grid[newRow][newCol] = 2
                    freshCount--
                    queue = append(queue, []int{newRow, newCol})
                    rottenThisMinute = true
                }
            }
        }
        if rottenThisMinute {
            minutes++
        }
    }

    if freshCount > 0 {
        return -1
    }

    return minutes
}