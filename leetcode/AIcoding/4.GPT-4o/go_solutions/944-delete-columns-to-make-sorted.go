func minDeletionSize(strs []string) int {
    count := 0
    n := len(strs)
    m := len(strs[0])

    for j := 0; j < m; j++ {
        for i := 1; i < n; i++ {
            if strs[i][j] < strs[i-1][j] {
                count++
                break
            }
        }
    }
    return count
}