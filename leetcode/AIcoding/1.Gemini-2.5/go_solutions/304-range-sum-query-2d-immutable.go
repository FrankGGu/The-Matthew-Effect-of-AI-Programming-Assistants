type NumMatrix struct {
	sums [][]int
}

func Constructor(matrix [][]int) NumMatrix {
	m := len(matrix)
	if m == 0 {
		return NumMatrix{sums: [][]int{}}
	}
	n := len(matrix[0])
	if n == 0 {
		return NumMatrix{sums: [][]int{}}
	}

	sums := make([][]int, m+1)
	for i := range sums {
		sums[i] = make([]int, n+1)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			sums[i+1][j+1] = matrix[i][j] + sums[i][j+1] + sums[i+1][j] - sums[i][j]
		}
	}

	return NumMatrix{sums: sums}
}

func (this *NumMatrix) SumRegion(row1 int, col1 int, row2 int, col2 int) int {
	// Adjust coordinates for 1-based indexing in sums array
	// The sum of the region (row1, col1) to (row2, col2) is:
	// sums[row2+1][col2+1]
	// - sums[row1][col2+1] (subtract top rectangle)
	// - sums[row2+1][col1] (subtract left rectangle)
	// + sums[row1][col1] (add back the top-left overlapping rectangle that was subtracted twice)
	return this.sums[row2+1][col2+1] - this.sums[row1][col2+1] - this.sums[row2+1][col1] + this.sums[row1][col1]
}