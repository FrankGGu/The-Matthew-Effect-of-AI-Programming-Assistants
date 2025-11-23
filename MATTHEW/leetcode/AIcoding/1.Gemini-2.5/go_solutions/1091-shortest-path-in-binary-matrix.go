type Cell struct {
    r, c, dist int
}

func shortestPathBinaryMatrix(grid [][]int) int {
    n := len(grid)

    // Edge case: Start or end cell is blocked
    if grid[0][0] == 1 || grid[n-1][n-1] == 1 {
        return -1
    }

    // Edge case: 1x1 grid
    if n == 1 {
        return 1 // Since grid[0][0] must be 0 at this point
    }

    // 8-directional movement vectors
    dr := []int{-1, -1, -1, 0, 0, 1, 1, 1}
    dc := []int{-1, 0, 1, -1, 1, -1, 0, 1}

    // BFS Queue
    queue := []Cell{}
    queue = append(queue, Cell{r: 0, c: 0, dist: 1})

    // Visited array to keep track of visited cells
    visited := make([][]bool, n)
    for i := range visited {
        visited[