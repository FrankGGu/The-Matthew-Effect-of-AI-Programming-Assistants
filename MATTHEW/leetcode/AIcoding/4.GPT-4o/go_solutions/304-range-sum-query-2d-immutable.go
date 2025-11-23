type NumMatrix struct {
    sum [][]int
}

func Constructor(matrix [][]int) NumMatrix {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return NumMatrix{}
    }
    rows, cols := len(matrix), len(matrix[0])
    sum := make([][]int, rows+1)
    for i := range sum {
        sum[i] = make([]int, cols+1)
    }
    for i := 1; i <= rows; i++ {
        for j := 1; j <= cols; j++ {
            sum[i][j] = matrix[i-1][j-1] + sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1]
        }
    }
    return NumMatrix{sum: sum}
}

func (this *NumMatrix) SumRegion(row1 int, col1 int, row2 int, col2 int) int {
    return this.sum[row2+1][col2+1] - this.sum[row1][col2+1] - this.sum[row2+1][col1] + this.sum[row1][col1]
}