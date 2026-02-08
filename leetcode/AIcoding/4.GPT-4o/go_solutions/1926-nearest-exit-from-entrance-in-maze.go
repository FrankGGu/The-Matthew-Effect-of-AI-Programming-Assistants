func nearestExit(maze [][]byte, entrance []int) int {
    rows, cols := len(maze), len(maze[0])
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    queue := [][]int{entrance}
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }
    visited[entrance[0]][entrance[1]] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[0]
            queue = queue[1:]
            x, y := curr[0], curr[1]

            if (x != entrance[0] || y != entrance[1]) && (x == 0 || x == rows-1 || y == 0 || y == cols-1) {
                return steps
            }

            for _, dir := range directions {
                nx, ny := x+dir[0], y+dir[1]
                if nx >= 0 && ny >= 0 && nx < rows && ny < cols && maze[nx][ny] == '.' && !visited[nx][ny] {
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny})
                }
            }
        }
        steps++
    }
    return -1
}