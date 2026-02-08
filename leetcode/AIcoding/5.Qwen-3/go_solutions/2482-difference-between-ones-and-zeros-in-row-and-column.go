package main

func onesMinusZeros(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])
    rowOnes := make([]int, m)
    colOnes := make([]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            rowOnes[i] += grid[i][j]
            colOnes[j] += grid[i][j]
        }
    }

    result := make([][]int, m)
    for i := 0; i < m; i++ {
        result[i] = make([]int, n)
        for j := 0; j < n; j++ {
            result[i][j] = 2*(rowOnes[i] + colOnes[j]) - m - n
        }
    }

    return result
}