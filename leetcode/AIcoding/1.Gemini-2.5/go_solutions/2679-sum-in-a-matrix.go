func matrixSum(nums [][]int) int {
	m := len(nums)
	n := len(nums[0])

	// Sort each row in ascending order
	for i := 0; i < m; i++ {
		sort.Ints(nums[i])
	}

	totalScore := 0

	// Iterate through columns
	// For each column index j, find the maximum element among nums[0][j], nums[1][j], ..., nums[m-1][j]
	// and add it to the total score.
	for j := 0; j < n; j++ {
		currentMax := 0
		for i := 0; i < m; i++ {
			if nums[i][j] > currentMax {
				currentMax = nums[i][j]
			}