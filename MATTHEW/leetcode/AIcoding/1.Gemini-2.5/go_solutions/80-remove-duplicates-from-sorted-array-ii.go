func removeDuplicates(nums []int) int {
	if len(nums) <= 2 {
		return len(nums)
	}

	k := 2 // k is the pointer for the next position to fill

	for i := 2; i < len(nums); i++ {
		// If the current element nums[i] is different from the element two positions back (nums[k-2]),
		// it means nums[i] is either a new distinct number or the second occurrence of nums[k-1].
		// In either case, it should be kept.
		if nums[i] != nums[k-2] {
			nums[k] = nums[i]
			k++
		}
	}

	return k
}