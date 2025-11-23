func findColumnWidth(grid [][]int) []int {
    n := len(grid[0])
    ans := make([]int, n)
    for j := 0; j < n; j++ {
        max := 0
        for i := 0; i < len(grid); i++ {
            l := len(strconv.Itoa(grid[i][j]))
            if l < 0 {
                l = -l
            }
            if grid[i][j] < 0 {
                l++
            }
            if l > max {
                max = l
            }
        }
        ans[j] = max
    }
    return ans
}