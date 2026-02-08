package main

func differenceOfDistinctValues(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            distinctTopLeft := make(map[int]bool)
            x, y := i-1, j-1
            for x >= 0 && y >= 0 {
                distinctTopLeft[grid[x][y]] = true
                x--
                y--
            }
            countTopLeft := len(distinctTopLeft)

            distinctBottomRight := make(map[int]bool)
            x, y = i+1, j+1
            for x < m && y < n {
                distinctBottomRight[grid[x][y]] = true
                x++
                y++
            }
            countBottomRight := len(distinctBottomRight)

            result[i][j] = abs(countTopLeft - countBottomRight)
        }
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}