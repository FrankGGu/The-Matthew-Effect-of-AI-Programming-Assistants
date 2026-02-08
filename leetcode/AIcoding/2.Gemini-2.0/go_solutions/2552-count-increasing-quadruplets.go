func countQuadruplets(nums []int) int64 {
	n := len(nums)
	count := int64(0)
	for j := 1; j < n-2; j++ {
		for k := j + 1; k < n-1; k++ {
			if nums[j] > nums[k] {
				less := 0
				more := 0
				for i := 0; i < j; i++ {
					if nums[i] < nums[k] {
						less++
					}
				}
				for l := k + 1; l < n; l++ {
					if nums[l] > nums[j] {
						more++
					}
				}
				count += int64(less * more)
			}
		}
	}
	return count
}