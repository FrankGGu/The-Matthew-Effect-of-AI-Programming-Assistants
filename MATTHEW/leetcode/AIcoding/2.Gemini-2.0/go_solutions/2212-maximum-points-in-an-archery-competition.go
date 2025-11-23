func maximumBobPoints(numArrows int, aliceArrows []int) []int {
	n := len(aliceArrows)
	maxPoints := -1
	var bestBobArrows []int

	for mask := 0; mask < (1 << n); mask++ {
		currentArrows := numArrows
		currentPoints := 0
		bobArrows := make([]int, n)

		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				neededArrows := aliceArrows[i] + 1
				if currentArrows >= neededArrows {
					currentArrows -= neededArrows
					currentPoints += i
					bobArrows[i] = neededArrows
				} else {
					currentPoints = -1
					break
				}
			}
		}

		if currentPoints > maxPoints {
			maxPoints = currentPoints
			bestBobArrows = bobArrows
			bestBobArrows[0] += currentArrows
		}
	}

	return bestBobArrows
}