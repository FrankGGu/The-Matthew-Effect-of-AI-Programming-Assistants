func orangesRotting(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    queue := [][]int{}
    fresh := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 2 {
                queue = append(queue, []int{i, j})
            } else if grid[i][j] == 1 {
                fresh++
            }
        }
    }
    if fresh == 0 {
        return 0
    }
    dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    minutes := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            curr := queue[0]
            queue = queue[1:]
            for _, dir := range dirs {
                x, y := curr[0]+dir[0], curr[1]+dir[1]
                if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 1 {
                    grid[x][y] = 2
                    fresh--
                    queue = append(queue, []int{x, y})
                }
            }
        }
        if len(queue) > 0 {
            minutes++
        }
    }
    if fresh == 0 {
        return minutes
    }
    return -1
}