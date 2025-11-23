func distinctAverages(nums []int) int {
	sort.Ints(nums)

	seenAverages := make(map[float64]struct{})

	left := 0
	right := len(nums) - 1

	for left < right {
		sum := nums[left] + nums[right]
		average := float64(sum) / 2.0
		seenAverages[average] = struct{}{}
		left++
		right--
	}

	return len(seenAverages)
}