func isSafe(grid [][]int, x, y int) bool {
    return x >= 0 && x < len(grid) && y >= 0 && y < len(grid[0]) && grid[x][y] == 0
}

func dfs(grid [][]int, x, y int, visited [][]bool) bool {
    if x == len(grid)-1 && y == len(grid[0])-1 {
        return true
    }

    visited[x][y] = true
    directions := [][]int{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}

    for _, dir := range directions {
        newX, newY := x+dir[0], y+dir[1]
        if isSafe(grid, newX, newY) && !visited[newX][newY] {
            if dfs(grid, newX, newY, visited) {
                return true
            }
        }
    }

    visited[x][y] = false
    return false
}

func canWalkThrough(grid [][]int) bool {
    if len(grid) == 0 || grid[0][0] == 1 {
        return false
    }

    visited := make([][]bool, len(grid))
    for i := range visited {
        visited[i] = make([]bool, len(grid[0]))
    }

    return dfs(grid, 0, 0, visited)
}