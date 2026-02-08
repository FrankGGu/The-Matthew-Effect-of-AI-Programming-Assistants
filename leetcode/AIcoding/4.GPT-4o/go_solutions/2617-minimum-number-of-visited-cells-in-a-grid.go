func minVisitedCells(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    directions := []struct{dx, dy int}{1, 0, 0, 1}
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }
    queue := [][]int{{0, 0, 1}}
    visited[0][0] = true

    for len(queue) > 0 {
        cur := queue[0]
        queue = queue[1:]
        x, y, step := cur[0], cur[1], cur[2]
        if x == m-1 && y == n-1 {
            return step
        }
        for _, dir := range directions {
            for i := 1; i <= grid[x][y]; i++ {
                nx, ny := x+dir.dx*i, y+dir.dy*i
                if nx < m && ny < n && !visited[nx][ny] {
                    visited[nx][ny] = true
                    queue = append(queue, []int{nx, ny, step + 1})
                }
            }
        }
    }
    return -1
}