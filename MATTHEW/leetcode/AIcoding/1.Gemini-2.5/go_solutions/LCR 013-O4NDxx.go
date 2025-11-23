type NumMatrix struct {
	prefixSum [][]int
}

func Constructor(matrix [][]int) NumMatrix {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return NumMatrix{}
	}

	m := len(matrix)
	n := len(matrix[0])

	prefixSum := make([][]int, m+1)
	for i := range prefixSum {
		prefixSum[i] = make([]int, n+1)
	}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			prefixSum[r+1][c+1] = matrix[r][c] + prefixSum[r][c+1] + prefixSum[r+1][c] - prefixSum[r][c]
		}
	}

	return NumMatrix{prefixSum: prefixSum}
}

func (this *NumMatrix) SumRegion(row1 int, col1 int, row2 int, col2 int) int {
	return this.prefixSum[row2+1][col2+1] - this.prefixSum[row1][col2+1] - this.prefixSum[row2+1][col1] + this.prefixSum[row1][col1]
}