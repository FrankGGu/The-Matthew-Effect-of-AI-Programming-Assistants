func findPrefixScore(nums []int) []int64 {
	n := len(nums)
	ans := make([]int64, n)

	var currentMax int64 = 0
	var prefixSumOfScores int64 = 0

	for i := 0; i < n; i++ {
		if int64(nums[i]) > currentMax {
			currentMax = int64(nums[i])
		}

		currentScoreComponent := int64(nums[i]) + currentMax
		prefixSumOfScores += currentScoreComponent
		ans[i] = prefixSumOfScores
	}

	return ans
}