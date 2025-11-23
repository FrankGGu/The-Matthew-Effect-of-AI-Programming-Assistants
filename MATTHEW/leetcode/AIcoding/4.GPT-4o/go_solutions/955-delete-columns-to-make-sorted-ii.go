func minDeletionSize(strs []string) int {
    n := len(strs)
    if n == 0 {
        return 0
    }

    m := len(strs[0])
    deleteCount := 0
    columnsToDelete := make([]bool, m)

    for j := 0; j < m; j++ {
        for i := 1; i < n; i++ {
            if columnsToDelete[j] {
                break
            }
            if strs[i][j] < strs[i-1][j] {
                deleteCount++
                columnsToDelete[j] = true
                break
            }
        }
    }

    return deleteCount
}