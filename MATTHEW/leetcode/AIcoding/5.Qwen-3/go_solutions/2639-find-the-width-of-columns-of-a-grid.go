package main

func gridInterview(grid [][]string) []int {
    if len(grid) == 0 {
        return []int{}
    }
    cols := make([]int, len(grid[0]))
    for _, row := range grid {
        for i, cell := range row {
            if len(cell) > cols[i] {
                cols[i] = len(cell)
            }
        }
    }
    return cols
}