func maxDistance(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    queue := [][]int{}
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] == 1 {
                queue = append(queue, []int{i, j})
            }
        }
    }

    if len(queue) == 0 || len(queue) == rows*cols {
        return -1
    }

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    distance := -1

    for len(queue) > 0 {
        distance++
        for size := len(queue); size > 0; size-- {
            point := queue[0]
            queue = queue[1:]
            for _, dir := range directions {
                newRow, newCol := point[0]+dir[0], point[1]+dir[1]
                if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 0 {
                    grid[newRow][newCol] = 1
                    queue = append(queue, []int{newRow, newCol})
                }
            }
        }
    }

    return distance
}