func alternatingSubarray(nums []int) int {
	n := len(nums)
	maxLen := -1
	for i := 0; i < n-1; i++ {
		if nums[i+1]-nums[i] == 1 {
			currLen := 2
			diff := -1
			for j := i + 2; j < n; j++ {
				if nums[j]-nums[j-1] == diff {
					currLen++
					diff *= -1
				} else {
					break
				}
			}
			if currLen > maxLen {
				maxLen = currLen
			}
		}
	}
	return maxLen
}