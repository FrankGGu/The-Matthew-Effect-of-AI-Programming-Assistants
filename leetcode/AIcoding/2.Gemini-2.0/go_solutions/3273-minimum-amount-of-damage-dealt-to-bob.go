func minDamage(powers []int, armor int) int64 {
	n := len(powers)
	maxPower := 0
	sum := 0
	for _, power := range powers {
		sum += power
		if power > maxPower {
			maxPower = power
		}
	}

	reducedDamage := min(armor, maxPower)
	return int64(max(0, sum-reducedDamage))
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}