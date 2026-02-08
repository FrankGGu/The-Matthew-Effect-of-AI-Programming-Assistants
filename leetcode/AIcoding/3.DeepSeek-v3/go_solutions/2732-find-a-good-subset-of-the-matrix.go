func goodSubsetofBinaryMatrix(grid [][]int) []int {
    m := len(grid)
    n := len(grid[0])
    maskMap := make(map[int]int)

    for i := 0; i < m; i++ {
        mask := 0
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                mask |= 1 << j
            }
        }
        if mask == 0 {
            return []int{i}
        }
        maskMap[mask] = i
    }

    for mask1, i := range maskMap {
        for mask2, j := range maskMap {
            if (mask1 & mask2) == 0 {
                if i < j {
                    return []int{i, j}
                } else {
                    return []int{j, i}
                }
            }
        }
    }

    return []int{}
}