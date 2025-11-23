func countTriplets(nums []int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		for j := 0; j < len(nums); j++ {
			for k := 0; k < len(nums); k++ {
				if (nums[i] & nums[j] & nums[k]) == 0 {
					count++
				}
			}
		}
	}
	return count
}