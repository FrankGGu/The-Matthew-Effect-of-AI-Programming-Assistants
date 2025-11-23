func rotateTheBox(box [][]byte) [][]byte {
	m := len(box)
	n := len(box[0])
	rotated := make([][]byte, n)
	for i := range rotated {
		rotated[i] = make([]byte, m)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			rotated[j][m-1-i] = box[i][j]
		}
	}

	for i := 0; i < n; i++ {
		lastObstacle := -1
		for j := 0; j < m; j++ {
			if rotated[i][j] == '*' {
				lastObstacle = j
			} else if rotated[i][j] == '#' {
				rotated[i][j] = '.'
				if lastObstacle == -1 {
					rotated[i][0] = '#'
				} else {
					rotated[i][lastObstacle+1] = '#'
					lastObstacle++
				}
			}
		}
	}

	return rotated
}