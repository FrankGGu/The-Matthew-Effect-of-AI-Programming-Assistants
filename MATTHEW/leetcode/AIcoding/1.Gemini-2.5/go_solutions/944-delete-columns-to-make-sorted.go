func minDeletionSize(strs []string) int {
    if len(strs) == 0 {
        return 0
    }

    deleteCount := 0
    numRows := len(strs)
    numCols := len(strs[0])

    for j := 0; j < numCols; j++ {
        for i := 0; i < numRows-1; i++ {
            if strs[i][j] > strs[i+1][j] {
                deleteCount++
                break
            }
        }
    }

    return deleteCount
}