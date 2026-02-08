func findColumnWidth(grid [][]int) []int {
    if len(grid) == 0 {
        return []int{}
    }
    m, n := len(grid), len(grid[0])
    res := make([]int, n)
    for j := 0; j < n; j++ {
        maxLen := 0
        for i := 0; i < m; i++ {
            num := grid[i][j]
            length := 1
            if num < 0 {
                length++
                num = -num
            }
            for num >= 10 {
                length++
                num /= 10
            }
            if length > maxLen {
                maxLen = length
            }
        }
        res[j] = maxLen
    }
    return res
}