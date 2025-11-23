func countNegatives(grid [][]int) int {
    count := 0
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])

    for i := 0; i < rows; i++ {
        left, right := 0, cols-1
        for left <= right {
            mid := left + (right - left) / 2
            if grid[i][mid] < 0 {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        count += cols - left
    }
    return count
}