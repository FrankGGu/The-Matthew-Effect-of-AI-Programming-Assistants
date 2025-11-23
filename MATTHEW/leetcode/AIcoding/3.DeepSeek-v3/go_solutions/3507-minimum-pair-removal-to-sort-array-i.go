func minDeletionSize(strs []string) int {
    count := 0
    for col := 0; col < len(strs[0]); col++ {
        for row := 1; row < len(strs); row++ {
            if strs[row][col] < strs[row-1][col] {
                count++
                break
            }
        }
    }
    return count
}