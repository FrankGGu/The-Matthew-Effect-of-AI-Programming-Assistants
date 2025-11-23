func movesToChessboard(board [][]int) int {
	n := len(board)
	rowMask := 0
	for i := 0; i < n; i++ {
		rowMask |= board[0][i] << i
	}
	rowInvert := rowMask ^ ((1 << n) - 1)
	rowCnt := 0
	invertCnt := 0
	for i := 0; i < n; i++ {
		curMask := 0
		for j := 0; j < n; j++ {
			curMask |= board[i][j] << j
		}
		if curMask != rowMask && curMask != rowInvert {
			return -1
		}
		if curMask == rowMask {
			rowCnt++
		}
		if board[i][0] == 1 {
			invertCnt++
		}
	}
	if rowCnt != n/2 && rowCnt != (n+1)/2 {
		return -1
	}
	colMask := 0
	for i := 0; i < n; i++ {
		colMask |= board[i][0] << i
	}
	colInvert := colMask ^ ((1 << n) - 1)
	colCnt := 0
	invertCnt2 := 0
	for i := 0; i < n; i++ {
		curMask := 0
		for j := 0; j < n; j++ {
			curMask |= board[j][i] << j
		}
		if curMask != colMask && curMask != colInvert {
			return -1
		}
		if curMask == colMask {
			colCnt++
		}
		if board[0][i] == 1 {
			invertCnt2++
		}
	}

	if colCnt != n/2 && colCnt != (n+1)/2 {
		return -1
	}

	rowMoves := minMoves(rowMask, n)
	colMoves := minMoves(colMask, n)

	if rowMoves == -1 || colMoves == -1 {
		return -1
	}

	return rowMoves + colMoves
}

func minMoves(mask int, n int) int {
	ones := 0
	for i := 0; i < n; i++ {
		if (mask>>i)&1 == 1 {
			ones++
		}
	}
	if ones != n/2 && ones != (n+1)/2 {
		return -1
	}
	moves := 0
	for i := 0; i < n; i += 2 {
		if (mask>>i)&1 != 0 {
			moves++
		}
	}
	if n%2 == 1 {
		return min(moves, n/2+1-moves)
	} else {
		return min(moves, n/2-moves)
	}
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}