import "sort"

func deleteGreatestValue(grid [][]int) int {
    m := len(grid)
    n := len(grid[0])

    // Sort each row in ascending order
    // After sorting, the greatest value in each row will always be at the end.
    for i := 0; i <