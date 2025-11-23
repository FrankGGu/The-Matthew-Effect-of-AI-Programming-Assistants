func brokenCalc(startValue int, target int) int {
	operations := 0

	for target > startValue {
		if target%2 == 0 {
			target /= 2
		} else {
			target += 1
		}
		operations++
	}

	// At this point, target <=