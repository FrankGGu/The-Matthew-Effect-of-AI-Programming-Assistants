package main

func maxDistance(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    queue := [][]int{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                queue = append(queue, []int{i, j})
            }
        }
    }
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    dist := -1
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            for _, dir := range directions {
                x, y := cell[0]+dir[0], cell[1]+dir[1]
                if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 0 {
                    grid[x][y] = -1
                    queue = append(queue, []int{x, y})
                }
            }
        }
        dist++
    }
    return dist
}