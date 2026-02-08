func largestIsland(grid [][]int) int {
    n := len(grid)
    color := 2
    area := make(map[int]int)
    maxArea := 0

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                queue := [][]int{{i, j}}
                grid[i][j] = color
                currentArea := 0

                for len(queue) > 0 {
                    cell := queue[0]
                    queue = queue[1:]
                    currentArea++

                    for _, dir := range directions {
                        x, y := cell[0]+dir[0], cell[1]+dir[1]
                        if x >= 0 && x < n && y >= 0 && y < n && grid[x][y] == 1 {
                            grid[x][y] = color
                            queue = append(queue, []int{x, y})
                        }
                    }
                }

                area[color] = currentArea
                if currentArea > maxArea {
                    maxArea = currentArea
                }
                color++
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                colors := make(map[int]bool)
                current := 1

                for _, dir := range directions {
                    x, y := i+dir[0], j+dir[1]
                    if x >= 0 && x < n && y >= 0 && y < n && grid[x][y] > 1 {
                        c := grid[x][y]
                        if !colors[c] {
                            current += area[c]
                            colors[c] = true
                        }
                    }
                }

                if current > maxArea {
                    maxArea = current
                }
            }
        }
    }

    return maxArea
}