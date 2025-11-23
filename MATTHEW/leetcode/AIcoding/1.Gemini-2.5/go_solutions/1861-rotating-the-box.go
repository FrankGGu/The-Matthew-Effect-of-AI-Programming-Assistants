func rotateTheBox(box [][]byte) [][]byte {
	m := len(box)
	n := len(box[0])

	rotatedBox := make([][]byte, n)
	for i := range rotatedBox {
		rotatedBox[i] = make([]byte, m)
	}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			rotatedBox[c][m-1-r] = box[r][c]
		}
	}

	numRowsRotated := n
	numColsRotated := m

	for j := 0; j < numColsRotated; j++ {
		emptySlotRow := numRowsRotated - 1

		for i := numRowsRotated - 1; i >= 0; i-- {
			if rotatedBox[i][j] == '*' {
				emptySlotRow = i - 1
			} else if rotatedBox[i][j] == '#' {
				if i != emptySlotRow {
					rotatedBox[emptySlotRow][j] = '#'
					rotatedBox[i][j] = '.'
				}
				emptySlotRow--
			}
		}
	}

	return rotatedBox
}