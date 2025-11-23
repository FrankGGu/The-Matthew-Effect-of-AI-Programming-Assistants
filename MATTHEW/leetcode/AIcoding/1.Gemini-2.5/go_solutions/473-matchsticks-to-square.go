func makesquare(matchsticks []int) bool {
	n := len(matchsticks)
	if n < 4 {
		return false
	}

	totalSum := 0
	for _, l := range matchsticks {
		totalSum += l
	}

	if totalSum%