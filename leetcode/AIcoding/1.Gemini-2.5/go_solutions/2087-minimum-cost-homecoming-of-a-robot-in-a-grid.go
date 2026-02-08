func minCost(startPos []int, homePos []int, rowCosts []int, colCosts []int) int {
	totalCost := 0

	startR, startC := startPos[0], startPos[1]
	homeR, homeC := homePos[0], homePos[1]

	if startR < homeR {
		for r := startR + 1; r <= homeR; r++ {
			totalCost += rowCosts[r]
		}
	} else if startR > homeR {
		for r := startR - 1; r >= homeR; r-- {
			totalCost += rowCosts[r]
		}
	}

	if startC < homeC {
		for c := startC + 1; c <= homeC; c++ {
			totalCost += colCosts[c]
		}
	} else if startC > homeC {
		for c := startC - 1; c >= homeC; c-- {
			totalCost += colCosts[c]
		}
	}

	return totalCost
}