package main

func shiftGrid(grid [][]int, k int) [][]int {
    rows := len(grid)
    cols := len(grid[0])
    total := rows * cols
    result := make([][]int, rows)
    for i := range result {
        result[i] = make([]int, cols)
    }
    for i := 0; i < total; i++ {
        newIdx := (i + k) % total
        result[newIdx/cols][newIdx%cols] = grid[i/rows][i%rows]
    }
    return result
}