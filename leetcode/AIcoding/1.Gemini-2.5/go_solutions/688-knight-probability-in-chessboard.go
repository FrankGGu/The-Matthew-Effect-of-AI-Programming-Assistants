func knightProbOnBoard(N int, K int, r int, c int) float64 {
	dr := []int{-2, -2, -1, -1, 1, 1, 2, 2}
	dc := []int{-1, 1, -2, 2, -2, 2