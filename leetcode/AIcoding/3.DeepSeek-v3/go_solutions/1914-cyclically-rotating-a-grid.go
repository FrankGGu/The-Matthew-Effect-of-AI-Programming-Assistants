func rotateGrid(grid [][]int, k int) [][]int {
    m, n := len(grid), len(grid[0])
    layers := min(m, n) / 2
    for l := 0; l < layers; l++ {
        elements := []int{}
        top, bottom, left, right := l, m-1-l, l, n-1-l

        for i := left; i < right; i++ {
            elements = append(elements, grid[top][i])
        }
        for i := top; i < bottom; i++ {
            elements = append(elements, grid[i][right])
        }
        for i := right; i > left; i-- {
            elements = append(elements, grid[bottom][i])
        }
        for i := bottom; i > top; i-- {
            elements = append(elements, grid[i][left])
        }

        total := len(elements)
        shift := k % total
        rotated := append(elements[shift:], elements[:shift]...)

        idx := 0
        for i := left; i < right; i++ {
            grid[top][i] = rotated[idx]
            idx++
        }
        for i := top; i < bottom; i++ {
            grid[i][right] = rotated[idx]
            idx++
        }
        for i := right; i > left; i-- {
            grid[bottom][i] = rotated[idx]
            idx++
        }
        for i := bottom; i > top; i-- {
            grid[i][left] = rotated[idx]
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