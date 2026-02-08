func countSubarrays(nums []int, k int) int64 {
	n := len(nums)
	maxVal := 0
	for _, num := range nums {
		if num > maxVal {
			maxVal = num
		}
	}

	ans := int64(0)
	for i := 0; i < n; i++ {
		count := 0
		for j := i; j < n; j++ {
			if nums[j] == maxVal {
				count++
			}
			if count >= k {
				ans += int64(n - j)
				break
			}
		}
	}

	return ans
}