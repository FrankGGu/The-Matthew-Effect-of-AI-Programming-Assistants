package main

func firstCompleteFullyPaintedRowOrColumn(arr []int, mat [][]int) int {
	m := len(mat)
	n := len(mat[0])

	numToCoords := make(map[int][2]int, m*n)
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			numToCoords[mat[r][c]] = [2]int{r, c}
		}
	}

	rowRemaining := make([]int, m)
	for i := range rowRemaining {
		rowRemaining[i] = n
	}

	colRemaining := make([]int, n)
	for i := range colRemaining {
		colRemaining[i] = m
	}

	for k, num := range arr {
		coords := numToCoords[num]
		r, c := coords[0], coords[1]

		rowRemaining[r]--
		colRemaining[c]--

		if rowRemaining[r] == 0 || colRemaining[c] == 0 {
			return k
		}
	}

	return -1
}