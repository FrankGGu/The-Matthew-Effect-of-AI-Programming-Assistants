func findMissingAndRepeatedValues(grid [][]int) []int {
    n := len(grid)
    count := make([]int, n*n+1)
    repeated := 0
    missing := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            count[grid[i][j]]++
        }
    }
    for i := 1; i <= n*n; i++ {
        if count[i] == 0 {
            missing = i
        } else if count[i] > 1 {
            repeated = i
        }
    }
    return []int{repeated, missing}
}