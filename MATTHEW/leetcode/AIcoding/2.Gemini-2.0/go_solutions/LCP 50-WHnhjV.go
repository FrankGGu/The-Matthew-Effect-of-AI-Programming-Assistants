func giveGem(gem []int, operations [][]int) int {
	for _, op := range operations {
		x := op[0]
		y := op[1]
		give := gem[x] / 2
		gem[x] -= give
		gem[y] += give
	}

	minVal := gem[0]
	maxVal := gem[0]
	for _, g := range gem {
		if g < minVal {
			minVal = g
		}
		if g > maxVal {
			maxVal = g
		}
	}

	return maxVal - minVal
}