func spiralMatrixIII(rows int, cols int, rStart int, cStart int) [][]int {
    result := [][]int{{rStart, cStart}}
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    steps := 1
    dir := 0

    for len(result) < rows*cols {
        for i := 0; i < 2; i++ {
            for j := 0; j < steps; j++ {
                rStart += directions[dir][0]
                cStart += directions[dir][1]
                if rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols {
                    result = append(result, []int{rStart, cStart})
                }
            }
            dir = (dir + 1) % 4
        }
        steps++
    }

    return result
}