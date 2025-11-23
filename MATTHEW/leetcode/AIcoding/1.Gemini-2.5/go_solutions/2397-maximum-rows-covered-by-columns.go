func maximumRows(mat [][]int, cols int) int {
    m := len(mat)
    n := len(mat[0])

    rowMasks := make([]int, m)
    for i := 0; i < m; i++ {
        currentRowMask := 0
        for j := 0; j < n