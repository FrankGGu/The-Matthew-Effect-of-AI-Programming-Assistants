func minArea(mat [][]byte) int {
    rows, cols := len(mat), len(mat[0])
    left, right, top, bottom := cols, -1, rows, -1

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if mat[i][j] == '1' {
                if j < left {
                    left = j
                }
                if j > right {
                    right = j
                }
                if i < top {
                    top = i
                }
                if i > bottom {
                    bottom = i
                }
            }
        }
    }

    if left > right || top > bottom {
        return 0
    }

    return (right - left + 1) * (bottom - top + 1)
}