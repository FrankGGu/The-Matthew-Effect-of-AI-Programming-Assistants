func minCost(startPos []int, homePos []int, rowCosts []int, colCosts []int) int {
	rowCost := 0
	if startPos[0] < homePos[0] {
		for i := startPos[0] + 1; i <= homePos[0]; i++ {
			rowCost += rowCosts[i]
		}
	} else if startPos[0] > homePos[0] {
		for i := startPos[0] - 1; i >= homePos[0]; i-- {
			rowCost += rowCosts[i]
		}
	}

	colCost := 0
	if startPos[1] < homePos[1] {
		for i := startPos[1] + 1; i <= homePos[1]; i++ {
			colCost += colCosts[i]
		}
	} else if startPos[1] > homePos[1] {
		for i := startPos[1] - 1; i >= homePos[1]; i-- {
			colCost += colCosts[i]
		}
	}

	return rowCost + colCost
}