type Point struct {
    x, y int
}

func nearestExit(maze [][]byte, entrance []int) int {
    rows := len(maze)
    if rows == 0 {
        return -1
    }
    cols := len(maze[0])

    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    queue := []Point{{entrance[0], entrance[1]}}
    maze[entrance[0]][entrance[1]] = '+'
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            p := queue[i]
            if (p.x != entrance[0] || p.y != entrance[1]) && (p.x == 0 || p.x == rows-1 || p.y == 0 || p.y == cols-1) {
                return steps
            }
            for _, dir := range dirs {
                nx, ny := p.x + dir[0], p.y + dir[1]
                if nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] == '.' {
                    maze[nx][ny] = '+'
                    queue = append(queue, Point{nx, ny})
                }
            }
        }
        queue = queue[size:]
        steps++
    }

    return -1
}