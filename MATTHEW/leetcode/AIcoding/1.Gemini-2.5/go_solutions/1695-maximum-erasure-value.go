func maximumUniqueSubarray(nums []int) int {
	maxSum := 0
	currentSum := 0
	left := 0
	seen := make(map[int]bool)

	for right := 0; right < len(nums); right++ {
		num := nums[right]

		for seen[num] {
			delete(seen, nums[left])
			currentSum -= nums[left]
			left++
		}

		seen[num] = true
		currentSum += num
		maxSum = int(math.Max(float64(maxSum), float64(currentSum)))
	}

	return maxSum
}