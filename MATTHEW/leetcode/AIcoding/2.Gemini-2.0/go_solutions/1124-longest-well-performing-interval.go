func longestWPI(hours []int) int {
	n := len(hours)
	prefixSum := make([]int, n+1)
	for i := 1; i <= n; i++ {
		if hours[i-1] > 8 {
			prefixSum[i] = prefixSum[i-1] + 1
		} else {
			prefixSum[i] = prefixSum[i-1] - 1
		}
	}

	stack := []int{0}
	for i := 1; i <= n; i++ {
		if len(stack) == 0 || prefixSum[stack[len(stack)-1]] > prefixSum[i] {
			stack = append(stack, i)
		}
	}

	maxLen := 0
	for i := n; i >= 1; i-- {
		for len(stack) > 0 && prefixSum[stack[len(stack)-1]] < prefixSum[i] {
			maxLen = max(maxLen, i-stack[len(stack)-1])
			stack = stack[:len(stack)-1]
		}
	}

	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}