package main

func maxDistance(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    queue := [][]int{}
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                queue = append(queue, []int{i, j})
            }
        }
    }
    if len(queue) == 0 || len(queue) == n*m {
        return -1
    }
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    distance := 0
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            cell := queue[0]
            queue = queue[1:]
            for _, dir := range directions {
                x := cell[0] + dir[0]
                y := cell[1] + dir[1]
                if x >= 0 && x < n && y >= 0 && y < m && grid[x][y] == 0 {
                    grid[x][y] = -1
                    queue = append(queue, []int{x, y})
                }
            }
        }
        distance++
    }
    return distance - 1
}