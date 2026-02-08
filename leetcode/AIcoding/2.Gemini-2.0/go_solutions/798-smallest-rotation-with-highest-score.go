func smallestRotation(nums []int) int {
	n := len(nums)
	bad := make([]int, n)

	for i := 0; i < n; i++ {
		low := (i - nums[i] + 1 + n) % n
		bad[low]--
		high := (i + 1) % n
		bad[high]++
	}

	score := 0
	bestScore := -1
	bestIndex := -1

	for i := 0; i < n; i++ {
		score += bad[i]
		if score > bestScore {
			bestScore = score
			bestIndex = i
		}
	}

	return bestIndex
}