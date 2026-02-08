func countSubarrays(nums []int, k int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		andVal := nums[i]
		if andVal == k {
			count++
		}
		for j := i + 1; j < len(nums); j++ {
			andVal &= nums[j]
			if andVal == k {
				count++
			}
		}
	}
	return count
}