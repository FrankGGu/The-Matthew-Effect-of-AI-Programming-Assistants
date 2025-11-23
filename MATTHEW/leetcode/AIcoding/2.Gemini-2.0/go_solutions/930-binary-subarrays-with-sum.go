func numSubarraysWithSum(nums []int, goal int) int {
	n := len(nums)
	count := 0
	prefixSum := make([]int, n+1)
	freq := make(map[int]int)
	freq[0] = 1

	for i := 1; i <= n; i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i-1]
		diff := prefixSum[i] - goal
		if val, ok := freq[diff]; ok {
			count += val
		}
		freq[prefixSum[i]]++
	}

	return count
}