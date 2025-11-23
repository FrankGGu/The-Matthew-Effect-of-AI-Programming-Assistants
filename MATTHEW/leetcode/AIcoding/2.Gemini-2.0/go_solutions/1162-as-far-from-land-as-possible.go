func maxDistance(grid [][]int) int {
    n := len(grid)
    q := [][]int{}
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                q = append(q, []int{i, j})
            }
        }
    }

    if len(q) == 0 || len(q) == n*n {
        return -1
    }

    dist := 0
    dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for len(q) > 0 {
        size := len(q)
        for i := 0; i < size; i++ {
            curr := q[0]
            q = q[1:]

            for _, dir := range dirs {
                x := curr[0] + dir[0]
                y := curr[1] + dir[1]

                if x >= 0 && x < n && y >= 0 && y < n && grid[x][y] == 0 {
                    grid[x][y] = 2
                    q = append(q, []int{x, y})
                }
            }
        }
        dist++
    }

    return dist - 1
}