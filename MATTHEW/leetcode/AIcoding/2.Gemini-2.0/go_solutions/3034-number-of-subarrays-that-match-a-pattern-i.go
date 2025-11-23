func countMatchingSubarrays(nums []int, pattern []int) int {
	n := len(nums)
	m := len(pattern)
	count := 0

	for i := 0; i <= n-m-1; i++ {
		match := true
		for j := 0; j < m; j++ {
			if pattern[j] == 1 {
				if nums[i+j+1] <= nums[i+j] {
					match = false
					break
				}
			} else if pattern[j] == 0 {
				if nums[i+j+1] != nums[i+j] {
					match = false
					break
				}
			} else {
				if nums[i+j+1] >= nums[i+j] {
					match = false
					break
				}
			}
		}
		if match {
			count++
		}
	}

	return count
}