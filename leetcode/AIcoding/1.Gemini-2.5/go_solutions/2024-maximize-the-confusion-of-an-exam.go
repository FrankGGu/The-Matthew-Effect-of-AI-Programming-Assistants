func maxConsecutiveAnswers(answerKey string, k int) int {
	return max(solve(answerKey, k, 'T'), solve(answerKey, k, 'F'))
}

func solve(answerKey string, k int, target byte) int {
	n := len(answerKey)
	left := 0
	countOther := 0
	maxLength := 0

	for right := 0; right < n; right++ {
		if answerKey[right] != target {
			countOther++
		}

		for countOther > k {
			if answerKey[left] != target {
				countOther--
			}
			left++
		}

		maxLength = max(maxLength, right-left+1)
	}
	return maxLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}