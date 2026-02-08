func maxDistance(grid [][]int) int {
    n := len(grid)
    queue := [][]int{}
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                queue = append(queue, []int{i, j})
            }
        }
    }

    if len(queue) == 0 || len(queue) == n*n {
        return -1
    }

    distance := -1

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            point := queue[0]
            queue = queue[1:]
            for _, dir := range directions {
                x := point[0] + dir[0]
                y := point[1] + dir[1]
                if x >= 0 && x < n && y >= 0 && y < n && grid[x][y] == 0 {
                    grid[x][y] = 1
                    queue = append(queue, []int{x, y})
                }
            }
        }
        distance++
    }

    return distance
}