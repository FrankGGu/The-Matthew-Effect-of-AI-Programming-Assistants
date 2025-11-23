func maximumSumOfHeights(maxHeights []int) int64 {
	n := len(maxHeights)
	ans := int64(0)
	for i := 0; i < n; i++ {
		sum := int64(maxHeights[i])
		left := maxHeights[i]
		for j := i - 1; j >= 0; j-- {
			left = min(left, maxHeights[j])
			sum += int64(left)
		}
		right := maxHeights[i]
		for j := i + 1; j < n; j++ {
			right = min(right, maxHeights[j])
			sum += int64(right)
		}
		ans = max(ans, sum)
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}