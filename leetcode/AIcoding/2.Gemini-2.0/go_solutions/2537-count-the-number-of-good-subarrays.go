func countGoodSubarrays(nums []int, k int) int64 {
	n := len(nums)
	count := int64(0)
	left := 0
	xorMap := make(map[int]int)
	currXor := 0

	for right := 0; right < n; right++ {
		if val, ok := xorMap[nums[right]]; ok {
			currXor += val
		}
		xorMap[nums[right]]++

		for currXor >= k {
			count += int64(n - right)
			xorMap[nums[left]]--
			if val := xorMap[nums[left]]; val == 0 {
				delete(xorMap, nums[left])
			}
			if val, ok := xorMap[nums[left]]; ok {
				currXor -= val
			}
			left++
		}
	}

	return count
}