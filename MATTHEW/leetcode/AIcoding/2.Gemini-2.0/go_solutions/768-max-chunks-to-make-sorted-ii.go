func maxChunksToSorted(arr []int) int {
	n := len(arr)
	rightMin := make([]int, n+1)
	rightMin[n] = int(1e9 + 7)
	for i := n - 1; i >= 0; i-- {
		rightMin[i] = min(rightMin[i+1], arr[i])
	}

	leftMax := -1
	ans := 0
	for i := 0; i < n; i++ {
		leftMax = max(leftMax, arr[i])
		if leftMax <= rightMin[i+1] {
			ans++
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}