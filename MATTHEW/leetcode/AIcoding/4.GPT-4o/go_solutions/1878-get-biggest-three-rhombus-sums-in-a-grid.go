func getBiggestThree(grid [][]int) []int {
    rows, cols := len(grid), len(grid[0])
    sums := make(map[int]struct{})

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            for d := 0; d < min(rows, cols)/2; d++ {
                if r+d < rows && r+d < rows && c-d >= 0 && c+d < cols {
                    rhombusSum := 0
                    for k := 0; k <= d; k++ {
                        rhombusSum += grid[r+k][c] + grid[r+k][c-k] + grid[r+k][c+k] + grid[r-d+k][c] + grid[r-d+k][c-k] + grid[r-d+k][c+k]
                    }
                    sums[rhombusSum] = struct{}{}
                }
            }
        }
    }

    res := make([]int, 0)
    for sum := range sums {
        res = append(res, sum)
    }

    sort.Sort(sort.Reverse(sort.IntSlice(res)))
    if len(res) > 3 {
        res = res[:3]
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}