package leetcode

func tourOfKnight(knightPosition []int, gridSize int) bool {
    directions := [][]int{{2, 1}, {1, 2}, {-1, 2}, {-2, 1}, {-2, -1}, {-1, -2}, {1, -2}, {2, -1}}
    visited := make([][]bool, gridSize)
    for i := range visited {
        visited[i] = make([]bool, gridSize)
    }
    return dfs(knightPosition[0], knightPosition[1], 1, visited, directions, gridSize)
}

func dfs(x, y, step int, visited [][]bool, directions [][]int, gridSize int) bool {
    if step == gridSize*gridSize {
        return true
    }
    visited[x][y] = true
    for _, dir := range directions {
        nx, ny := x+dir[0], y+dir[1]
        if nx >= 0 && nx < gridSize && ny >= 0 && ny < gridSize && !visited[nx][ny] {
            if dfs(nx, ny, step+1, visited, directions, gridSize) {
                return true
            }
        }
    }
    visited[x][y] = false
    return false
}