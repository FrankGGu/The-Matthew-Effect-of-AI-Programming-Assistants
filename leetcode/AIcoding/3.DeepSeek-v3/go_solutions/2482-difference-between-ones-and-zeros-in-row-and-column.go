func onesMinusZeros(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])

    rowOnes := make([]int, m)
    colOnes := make([]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                rowOnes[i]++
                colOnes[j]++
            }
        }
    }

    diff := make([][]int, m)
    for i := 0; i < m; i++ {
        diff[i] = make([]int, n)
        for j := 0; j < n; j++ {
            diff[i][j] = 2 * (rowOnes[i] + colOnes[j]) - m - n
        }
    }

    return diff
}