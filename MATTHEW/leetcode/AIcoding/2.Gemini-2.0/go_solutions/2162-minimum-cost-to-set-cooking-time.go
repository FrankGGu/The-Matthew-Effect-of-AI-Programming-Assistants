func minCostSetTime(startAt int, moveCost int, pushCost int, targetSeconds int) int {
	minCost := int(1e9)
	for minutes := 0; minutes <= 99; minutes++ {
		seconds := targetSeconds - minutes*60
		if seconds < 0 || seconds > 99 {
			continue
		}

		digits := []int{}
		if minutes > 0 {
			digits = append(digits, minutes/10)
			digits = append(digits, minutes%10)
		} else {
			digits = append(digits, 0)
			digits = append(digits, 0)
		}
		digits = append(digits, seconds/10)
		digits = append(digits, seconds%10)

		firstNonZero := 0
		for firstNonZero < 4 && digits[firstNonZero] == 0 {
			firstNonZero++
		}

		cost := 0
		currentButton := startAt
		for i := firstNonZero; i < 4; i++ {
			if digits[i] != currentButton {
				cost += moveCost
				currentButton = digits[i]
			}
			cost += pushCost
		}
		if cost < minCost {
			minCost = cost
		}
	}

	return minCost
}