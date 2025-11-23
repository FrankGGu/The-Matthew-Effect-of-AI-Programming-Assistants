func minDeletionSize(strs []string) int {
    n := len(strs)
    if n == 0 {
        return 0
    }
    m := len(strs[0])
    res := 0
    for j := 0; j < m; j++ {
        for i := 1; i < n; i++ {
            if strs[i][j] < strs[i-1][j] {
                res++
                break
            }
        }
    }
    return res
}