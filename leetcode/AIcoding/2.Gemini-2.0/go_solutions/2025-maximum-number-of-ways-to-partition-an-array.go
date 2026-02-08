func waysToPartition(nums []int, k int) int {
	n := len(nums)
	prefixSum := make([]int, n)
	prefixSum[0] = nums[0]
	for i := 1; i < n; i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i]
	}

	totalSum := prefixSum[n-1]
	ans := 0
	count := make(map[int]int)

	for i := 0; i < n-1; i++ {
		if prefixSum[i] == totalSum-prefixSum[i] {
			ans++
		}
	}

	for i := 0; i < n; i++ {
		diff := k - nums[i]
		if val, ok := count[prefixSum[i]-diff]; ok {
			count[prefixSum[i]-diff] = val + 1
		} else {
			count[prefixSum[i]-diff] = 1
		}

	}

	maxCount := 0
	for i := 0; i < n; i++ {
		diff := k - nums[i]
		temp := 0
		if val, ok := count[prefixSum[i]-diff]; ok {
			temp = val
		}
		if temp > maxCount {
			maxCount = temp
		}
	}

	return maxCount
}