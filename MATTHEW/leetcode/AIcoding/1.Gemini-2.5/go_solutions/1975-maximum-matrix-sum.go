func maxMatrixSum(matrix [][]int) int64 {
	var totalSum int64 = 0
	negativeCount := 0
	minAbs := math.MaxInt

	for i := 0; i < len(matrix); i++ {
		for