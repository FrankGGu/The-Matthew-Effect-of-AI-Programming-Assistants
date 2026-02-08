func minFlips(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])
	flips := 0

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			rSym := rows - 1 - r