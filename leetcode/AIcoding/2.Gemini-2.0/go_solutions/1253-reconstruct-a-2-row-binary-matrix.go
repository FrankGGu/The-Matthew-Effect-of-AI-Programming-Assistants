func reconstructMatrix(upper int, lower int, colsum []int) [][]int {
	n := len(colsum)
	ans := make([][]int, 2)
	ans[0] = make([]int, n)
	ans[1] = make([]int, n)

	sum := 0
	for _, v := range colsum {
		sum += v
	}

	if sum != upper+lower {
		return [][]int{}
	}

	for i := 0; i < n; i++ {
		if colsum[i] == 2 {
			ans[0][i] = 1
			ans[1][i] = 1
			upper--
			lower--
		}
	}

	for i := 0; i < n; i++ {
		if colsum[i] == 1 {
			if upper > 0 {
				ans[0][i] = 1
				upper--
			} else {
				ans[1][i] = 1
				lower--
			}
		}
	}

	if upper != 0 || lower != 0 {
		return [][]int{}
	}

	return ans
}