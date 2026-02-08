func rotateGrid(grid [][]int, k int) [][]int {
    rows, cols := len(grid), len(grid[0])
    layers := min(rows, cols) / 2
    for layer := 0; layer < layers; layer++ {
        nums := []int{}
        for i := layer; i < cols-layer; i++ {
            nums = append(nums, grid[layer][i])
        }
        for i := layer + 1; i < rows-layer; i++ {
            nums = append(nums, grid[i][cols-layer-1])
        }
        for i := cols-layer-1; i >= layer && rows-layer-1 > layer; i-- {
            nums = append(nums, grid[rows-layer-1][i])
        }
        for i := rows-layer-2; i > layer && cols-layer-1 > layer; i-- {
            nums = append(nums, grid[i][layer])
        }
        n := len(nums)
        k = k % n
        rotated := append(nums[n-k:], nums[:n-k]...)
        idx := 0
        for i := layer; i < cols-layer; i++ {
            grid[layer][i] = rotated[idx]
            idx++
        }
        for i := layer + 1; i < rows-layer; i++ {
            grid[i][cols-layer-1] = rotated[idx]
            idx++
        }
        for i := cols-layer-1; i >= layer && rows-layer-1 > layer; i-- {
            grid[rows-layer-1][i] = rotated[idx]
            idx++
        }
        for i := rows-layer-2; i > layer && cols-layer-1 > layer; i-- {
            grid[i][layer] = rotated[idx]
            idx++
        }
    }
    return grid
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}