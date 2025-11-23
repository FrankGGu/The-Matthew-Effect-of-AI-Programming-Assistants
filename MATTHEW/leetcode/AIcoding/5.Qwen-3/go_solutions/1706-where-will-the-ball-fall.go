package main

func findBall(grid [][]int) []int {
    m := len(grid)
    n := len(grid[0])
    result := make([]int, n)
    for i := 0; i < n; i++ {
        result[i] = i
    }
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if result[j] == -1 {
                continue
            }
            nextCol := result[j] + grid[i][result[j]]
            if nextCol < 0 || nextCol >= n {
                result[j] = -1
            } else if grid[i][result[j]] != grid[i][nextCol] {
                result[j] = -1
            } else {
                result[j] = nextCol
            }
        }
    }
    return result
}