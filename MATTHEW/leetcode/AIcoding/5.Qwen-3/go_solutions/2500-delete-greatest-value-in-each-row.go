package main

func deleteGreatestValue(grid [][]int) int {
    for _, row := range grid {
        sort.Ints(row)
    }
    res := 0
    for j := 0; j < len(grid[0]); j++ {
        maxVal := 0
        for i := 0; i < len(grid); i++ {
            if grid[i][j] > maxVal {
                maxVal = grid[i][j]
            }
        }
        res += maxVal
    }
    return res
}