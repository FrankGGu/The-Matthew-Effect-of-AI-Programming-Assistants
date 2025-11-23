func minDeletionSize(strs []string) int {
    n := len(strs)
    if n == 0 {
        return 0
    }
    m := len(strs[0])
    res := 0
    sorted := make([]bool, n)

    for j := 0; j < m; j++ {
        prev := strs[0][j]
        needDelete := false
        for i := 1; i < n; i++ {
            if !sorted[i] && strs[i][j] < prev {
                needDelete = true
                break
            }
            prev = strs[i][j]
        }
        if needDelete {
            res++
        } else {
            for i := 1; i < n; i++ {
                if !sorted[i] && strs[i][j] > strs[i-1][j] {
                    sorted[i] = true
                }
            }
        }
    }
    return res
}