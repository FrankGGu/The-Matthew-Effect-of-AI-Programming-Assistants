package main

func countArtifacts(n int, m int, artifacts [][]int) int {
    grid := make([][]int, n)
    for i := range grid {
        grid[i] = make([]int, m)
    }
    for _, a := range artifacts {
        x1, y1, x2, y2 := a[0], a[1], a[2], a[3]
        for i := x1; i <= x2; i++ {
            for j := y1; j <= y2; j++ {
                grid[i][j]++
            }
        }
    }
    count := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                count++
            }
        }
    }
    return count
}