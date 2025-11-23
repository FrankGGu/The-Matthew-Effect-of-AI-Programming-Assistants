func flipChess(chessboard []string) int {
	m, n := len(chessboard), len(chessboard[0])
	maxFlip := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if chessboard[i][j] == '.' {
				flip := checkFlip(chessboard, i, j)
				if flip > maxFlip {
					maxFlip = flip
				}
			}
		}
	}
	return maxFlip
}

func checkFlip(chessboard []string, x, y int) int {
	m, n := len(chessboard), len(chessboard[0])
	temp := make([]string, m)
	for i := 0; i < m; i++ {
		temp[i] = chessboard[i]
	}
	bytes := []byte(temp[x])
	bytes[y] = 'X'
	temp[x] = string(bytes)

	flipCount := 0
	for dx := -1; dx <= 1; dx++ {
		for dy := -1; dy <= 1; dy++ {
			if dx == 0 && dy == 0 {
				continue
			}
			currX, currY := x+dx, y+dy
			if currX < 0 || currX >= m || currY < 0 || currY >= n || temp[currX][currY] == '.' || temp[currX][currY] == 'X' {
				continue
			}

			toFlip := []struct{ x, y int }{}

			nx, ny := currX, currY

			for nx >= 0 && nx < m && ny >= 0 && ny < n {
				if temp[nx][ny] == 'X' {
					for _, p := range toFlip {
						b := []byte(temp[p.x])
						b[p.y] = 'X'
						temp[p.x] = string(b)
						flipCount++
					}
					break
				} else if temp[nx][ny] == '.' {
					break
				} else {
					toFlip = append(toFlip, struct{ x, y int }{nx, ny})
				}

				nx += dx
				ny += dy
			}
		}
	}
	return flipCount
}