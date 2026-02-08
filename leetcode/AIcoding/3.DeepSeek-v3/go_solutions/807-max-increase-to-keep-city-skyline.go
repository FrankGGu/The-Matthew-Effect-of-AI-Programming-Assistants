func maxIncreaseKeepingSkyline(grid [][]int) int {
    n := len(grid)
    rowMax := make([]int, n)
    colMax := make([]int, n)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] > rowMax[i] {
                rowMax[i] = grid[i][j]
            }
            if grid[i][j] > colMax[j] {
                colMax[j] = grid[i][j]
            }
        }
    }

    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            min := rowMax[i]
            if colMax[j] < min {
                min = colMax[j]
            }
            total += min - grid[i][j]
        }
    }

    return total
}