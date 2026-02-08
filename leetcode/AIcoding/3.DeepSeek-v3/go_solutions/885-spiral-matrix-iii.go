func spiralMatrixIII(rows int, cols int, rStart int, cStart int) [][]int {
    res := make([][]int, rows*cols)
    res[0] = []int{rStart, cStart}
    if rows*cols == 1 {
        return res
    }

    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    step, dirIdx := 1, 0
    r, c := rStart, cStart
    count := 1

    for count < rows*cols {
        for i := 0; i < 2; i++ {
            for j := 0; j < step; j++ {
                r += dirs[dirIdx][0]
                c += dirs[dirIdx][1]
                if r >= 0 && r < rows && c >= 0 && c < cols {
                    res[count] = []int{r, c}
                    count++
                    if count == rows*cols {
                        return res
                    }
                }
            }
            dirIdx = (dirIdx + 1) % 4
        }
        step++
    }
    return res
}