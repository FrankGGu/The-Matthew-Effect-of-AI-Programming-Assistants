package main

func minimumDistance(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    var points []struct{ x, y int }
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                points = append(points, struct{ x, y int }{i, j})
            }
        }
    }
    if len(points) < 2 {
        return 0
    }
    minDist := 1<<31 - 1
    for i := 0; i < len(points); i++ {
        for j := i + 1; j < len(points); j++ {
            dist := abs(points[i].x-points[j].x) + abs(points[i].y-points[j].y)
            if dist < minDist {
                minDist = dist
            }
        }
    }
    return minDist
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}