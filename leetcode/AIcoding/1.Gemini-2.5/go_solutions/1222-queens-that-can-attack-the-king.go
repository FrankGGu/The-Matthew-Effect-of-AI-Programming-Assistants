func queensAttacktheKing(queens [][]int, king []int) [][]int {
	board := [8][8]bool{}
	for _, q := range queens {
		board[q[0]][q[1]] = true
	}

	result := [][]int{}
	kx, ky := king[0], king[1]

	dirs := [][]int{
		{-1, 0}, {1, 0}, {0, -1}, {0, 1},
		{-1, -1}, {-1, 1}, {1, -1}, {1, 1},
	}

	for _, dir := range dirs {
		dx, dy := dir[0], dir[1]
		x, y := kx+dx, ky+dy

		for x >= 0 && x < 8 && y >= 0 && y < 8 {
			if board[x][y] {
				result = append(result, []int{x, y})
				break
			}
			x += dx
			y += dy
		}
	}

	return result
}