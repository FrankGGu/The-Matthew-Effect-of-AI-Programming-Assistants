func destroyTargets(nums []int, space int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num%space]++
	}

	maxCount := 0
	target := -1
	for _, num := range nums {
		count := counts[num%space]
		if count > maxCount {
			maxCount = count
			target = num
		} else if count == maxCount && num < target {
			target = num
		}
	}

	return target
}