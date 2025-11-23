func arithmeticTriplets(nums []int, diff int) int {
	count := 0
	n := len(nums)
	for i := 0; i < n-2; i++ {
		for j := i + 1; j < n-1; j++ {
			if nums[j]-nums[i] == diff {
				for k := j + 1; k < n; k++ {
					if nums[k]-nums[j] == diff {
						count++
					}
				}
			}
		}
	}
	return count
}