func canBeIncreasing(nums []int) bool {
	count := 0
	prev := nums[0]

	for i := 1; i < len(nums); i++ {
		if nums[i] <= prev {
			count++
			if i > 1 && nums[i] <= nums[i-2] {
				nums[i] = prev
			}
		} else {
			prev = nums[i]
		}
	}

	return count <= 1
}