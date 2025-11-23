func checkMove(board []string, rMove int, cMove int, r int, c int) bool {
	startColor := board[rMove][cMove]
	if startColor == '.' {
		return false
	}

	endColor := board[r][c]
	if endColor == '.' {
		return false
	}
	if endColor == startColor {
		return false
	}

	dr := []int{-1, -1, -1, 0, 0, 1, 1, 1}
	dc := []int{-1, 0, 1, -1, 1, -1, 0, 1}

	for i := 0; i < 8; i++ {
		currR, currC := rMove+dr[i], cMove+dc[i]
		pathLength := 0

		for currR >= 0 && currR < 8 && currC >= 0 && currC < 8 {
			if currR == r && currC == c {
				return pathLength >= 1
			}

			if board[currR][currC] == '.' {
				pathLength++
				currR += dr[i]
				currC += dc[i]
			} else {
				break
			}
		}
	}

	return false
}