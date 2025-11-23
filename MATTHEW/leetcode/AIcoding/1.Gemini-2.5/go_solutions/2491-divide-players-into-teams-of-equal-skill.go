func dividePlayers(skill []int) int64 {
	n := len(skill)
	if n == 0 {
		return 0 // Or handle as an error case, but problem implies n >= 2
	}

	sort.Ints(skill)

	targetSum := skill[0] + skill[n-1]
	var totalChemistry int64 = 0

	left := 0
	right := n - 1

	for left < right {
		currentSum := skill[left] + skill[right]
		if currentSum != targetSum {
			return -1
		}
		totalChemistry += int64(skill[left]) * int64(skill[right])
		left++
		right--
	}

	return totalChemistry
}