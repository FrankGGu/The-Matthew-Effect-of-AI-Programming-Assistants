package main

func countBlackBlocks(m int64, n int64, coordinates [][]int) []int64 {
	if m < 2 || n < 2 {
		return []int64{0, 0, 0, 0, 0}
	}

	squareBlackCounts := make(map[[2]int]int)

	for _, coord := range coordinates {
		r_b, c_b := coord[0], coord[1]

		// A black cell (r_b, c_b) can be one of the four cells in a 2x2 square.
		// We determine the top-left corner (R, C) of such squares.

		// Case 1: (r_b, c_b) is the top-left cell of the 2x2 square
		// Top-left corner: (r_b, c_b)
		if int64(r_b) <= m-2 && int64(c_b) <= n-2 {
			squareBlackCounts[[2]int{r_b, c_b}]++
		}

		// Case 2: (r_b, c_b) is the top-right cell of the 2x2 square
		// Top-left corner: (r_b, c_b-1)
		if int64(r_b) <= m-2 && int64(c_b-1) >= 0 {
			squareBlackCounts[[2]int{r_b, c_b-1}]++
		}

		// Case 3: (r_b, c_b) is the bottom-left cell of the 2x2 square
		// Top-left corner: (r_b-1, c_b)
		if int64(r_b-1) >= 0 && int64(c_b) <= n-2 {
			squareBlackCounts[[2]int{r_b-1, c_b}]++
		}

		// Case 4: (r_b, c_b) is the bottom-right cell of the 2x2 square
		// Top-left corner: (r_b-1, c_b-1)
		if int64(r_b-1) >= 0 && int64(c_b-1) >= 0 {
			squareBlackCounts[[2]int{r_b-1, c_b-1}]++
		}
	}

	ans := make([]int64, 5) // ans[i] stores the count of 2x2 squares with i black cells

	for _, count := range squareBlackCounts {
		ans[count]++
	}

	totalPossibleSquares := (m - 1) * (n - 1)
	sumBlackSquares := ans[1] + ans[2] + ans[3] + ans[4]
	ans[0] = totalPossibleSquares - sumBlackSquares

	return ans
}