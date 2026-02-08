func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxScoreIndices(nums []int) []int {
	n := len(nums)
	ones := 0
	for _, num := range nums {
		if num == 1 {
			ones++
		}
	}

	maxScore := 0
	scores := make([]int, n+1)
	zeros := 0
	for i := 0; i < n; i++ {
		scores[i] = zeros + ones
		if nums[i] == 0 {
			zeros++
		} else {
			ones--
		}
		maxScore = max(maxScore, scores[i])
	}
	scores[n] = zeros + ones
	maxScore = max(maxScore, scores[n])

	result := []int{}
	for i := 0; i <= n; i++ {
		if scores[i] == maxScore {
			result = append(result, i)
		}
	}

	return result
}