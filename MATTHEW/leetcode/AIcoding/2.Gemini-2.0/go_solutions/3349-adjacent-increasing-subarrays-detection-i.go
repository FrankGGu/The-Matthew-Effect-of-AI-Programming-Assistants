func adjacentIncreasingSubarrays(nums []int) int {
	count := 0
	for i := 0; i < len(nums)-1; i++ {
		if nums[i] < nums[i+1] {
			count++
			j := i + 1
			for j < len(nums)-1 && nums[j] < nums[j+1] {
				j++
			}
			i = j
		}
	}
	return count
}