func minimumAverageDifference(nums []int) int {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	minAvgDiff := int(1e9 + 7)
	minIndex := 0

	for i := 0; i < n; i++ {
		avg1 := prefixSum[i+1] / (i + 1)
		avg2 := 0
		if i < n-1 {
			avg2 = (prefixSum[n] - prefixSum[i+1]) / (n - i - 1)
		}
		diff := abs(avg1 - avg2)

		if diff < minAvgDiff {
			minAvgDiff = diff
			minIndex = i
		}
	}

	return minIndex
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}