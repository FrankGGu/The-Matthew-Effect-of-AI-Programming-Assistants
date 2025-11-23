import "math"

func restoreMatrix(rowSum []int, colSum []int) [][]int {
	rows := len(rowSum)
	cols := len(colSum)

	result := make([][]int, rows)
	for i := range result {
		result[i] = make([]int, cols)
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			val := int(math.Min(float64(rowSum[i]), float64(colSum[j])))
			result[i][j] = val
			rowSum[i] -= val
			colSum[j] -= val