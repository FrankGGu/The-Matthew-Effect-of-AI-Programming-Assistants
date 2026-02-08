func largestDivisibleSubset(nums []int) []int {
	n := len(nums)
	if n == 0 {
		return []int{}
	}
	sort.Ints(nums)
	dp := make([]int, n)
	prev := make([]int, n)
	for i := range dp {
		dp[i] = 1
		prev[i] = -1
	}
	maxSize := 1
	maxIndex := 0
	for i := 1; i < n; i++ {
		for j := 0; j < i; j++ {
			if nums[i]%nums[j] == 0 {
				if dp[i] < dp[j]+1 {
					dp[i] = dp[j] + 1
					prev[i] = j
				}
			}
		}
		if dp[i] > maxSize {
			maxSize = dp[i]
			maxIndex = i
		}
	}
	result := make([]int, 0)
	for maxIndex != -1 {
		result = append(result, nums[maxIndex])
		maxIndex = prev[maxIndex]
	}
	return result
}