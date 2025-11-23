func swimInWater(grid [][]int) int {
    n := len(grid)
    left, right := grid[0][0], n*n

    for left < right {
        mid := (left + right) / 2
        if canSwim(grid, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canSwim(grid [][]int, t int) bool {
    n := len(grid)
    visited := make([][]bool, n)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := [][]int{{0, 0}}
    visited[0][0] = true

    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        if current[0] == n-1 && current[1] == n-1 {
            return true
        }

        for _, d := range directions {
            x, y := current[0]+d[0], current[1]+d[1]
            if x >= 0 && x < n && y >= 0 && y < n && !visited[x][y] && grid[x][y] <= t {
                visited[x][y] = true
                queue = append(queue, []int{x, y})
            }
        }
    }
    return false
}