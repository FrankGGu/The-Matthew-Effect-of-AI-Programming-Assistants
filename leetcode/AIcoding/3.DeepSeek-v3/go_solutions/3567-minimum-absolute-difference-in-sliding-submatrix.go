func minDifference(matrix [][]int, k int) int {
    m, n := len(matrix), len(matrix[0])
    minDiff := math.MaxInt32

    for i := 0; i <= m-k; i++ {
        for j := 0; j <= n-k; j++ {
            submatrix := make([]int, 0, k*k)
            for x := i; x < i+k; x++ {
                for y := j; y < j+k; y++ {
                    submatrix = append(submatrix, matrix[x][y])
                }
            }
            sort.Ints(submatrix)
            for l := 1; l < len(submatrix); l++ {
                diff := submatrix[l] - submatrix[l-1]
                if diff < minDiff {
                    minDiff = diff
                }
                if minDiff == 0 {
                    return 0
                }
            }
        }
    }
    return minDiff
}