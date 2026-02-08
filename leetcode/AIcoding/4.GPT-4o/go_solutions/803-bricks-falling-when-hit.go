func hitBricks(grid [][]int, hits [][]int) []int {
    rows, cols := len(grid), len(grid[0])
    directions := []int{-1, 0, 1, 0, -1}

    for _, hit := range hits {
        x, y := hit[0], hit[1]
        grid[x][y]--
    }

    find := func(x, y int) int {
        if x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] != 1 {
            return 0
        }
        grid[x][y] = 2
        count := 1
        for i := 0; i < 4; i++ {
            count += find(x+directions[i], y+directions[i+1])
        }
        return count
    }

    connect := func(x, y int) bool {
        if x == 0 {
            return true
        }
        for i := 0; i < 4; i++ {
            nx, ny := x+directions[i], y+directions[i+1]
            if nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] == 2 {
                return true
            }
        }
        return false
    }

    for j := 0; j < cols; j++ {
        if grid[0][j] == 1 {
            find(0, j)
        }
    }

    result := make([]int, len(hits))
    for i := len(hits) - 1; i >= 0; i-- {
        x, y := hits[i][0], hits[i][1]
        if grid[x][y] == 0 {
            grid[x][y]++
            if connect(x, y) {
                result[i] = find(x, y) - 1
            }
        }
    }

    return result
}