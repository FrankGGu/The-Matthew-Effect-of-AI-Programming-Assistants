type Point struct {
    x, y int
}

func shortestPathBinaryMatrix(grid [][]int) int {
    if grid[0][0] == 1 {
        return -1
    }
    n := len(grid)
    if n == 1 {
        return 1
    }
    directions := [8][2]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    queue := []Point{{0, 0}}
    grid[0][0] = 1
    steps := 1
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            p := queue[0]
            queue = queue[1:]
            for _, d := range directions {
                nx, ny := p.x+d[0], p.y+d[1]
                if nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] == 0 {
                    if nx == n-1 && ny == n-1 {
                        return steps + 1
                    }
                    queue = append(queue, Point{nx, ny})
                    grid[nx][ny] = 1
                }
            }
        }
        steps++
    }
    return -1
}