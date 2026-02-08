func canReachAllPoints(maze [][]int) bool {
    rows, cols := len(maze), len(maze[0])
    queue := [][]int{{0, 0}}
    visited := make(map[[2]int]bool)
    visited[[2]int{0, 0}] = true

    directions := []struct{ dx, dy int }{
        {0, 1}, {1, 0}, {0, -1}, {-1, 0},
    }

    for len(queue) > 0 {
        point := queue[0]
        queue = queue[1:]
        x, y := point[0], point[1]

        if x == rows-1 && y == cols-1 {
            return true
        }

        for _, dir := range directions {
            newX, newY := x+dir.dx, y+dir.dy
            if newX >= 0 && newX < rows && newY >= 0 && newY < cols && !visited[[2]int{newX, newY}] && maze[newX][newY] == 0 {
                visited[[2]int{newX, newY}] = true
                queue = append(queue, []int{newX, newY})
            }
        }
    }

    return false
}