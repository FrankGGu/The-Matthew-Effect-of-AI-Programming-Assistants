func maxConsecutiveAnswers(answerKey string, k int) int {
	maxLen := 0
	maxLen = max(maxLen, solve(answerKey, k, 'T'))
	maxLen = max(maxLen, solve(answerKey, k, 'F'))
	return maxLen
}

func solve(answerKey string, k int, ch byte) int {
	left, right := 0, 0
	count := 0
	maxLen := 0
	for right < len(answerKey) {
		if answerKey[right] != ch {
			count++
		}
		for count > k {
			if answerKey[left] != ch {
				count--
			}
			left++
		}
		maxLen = max(maxLen, right-left+1)
		right++
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}