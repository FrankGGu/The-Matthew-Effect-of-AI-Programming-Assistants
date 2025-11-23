type Point struct {
	X, Y int
}

func maximumMinutes(forest [][]int) int {
	m, n := len(forest), len(forest[0])
	q := []Point{}
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	canReach := func(minutes int) bool {
		q = []Point{}
		visited = make([][]bool, m)
		for i := range visited {
			visited[i] = make([]bool, n)
		}

		fire := make([][]int, m)
		for i := range fire {
			fire[i] = make([]int, n)
			for j := range fire[i] {
				fire[i][j] = -1
			}
		}

		q = []Point{}
		for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
				if forest[i][j] == 1 {
					q = append(q, Point{i, j})
					fire[i][j] = 0
				}
			}
		}

		directions := []Point{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
		for len(q) > 0 {
			curr := q[0]
			q = q[1:]
			for _, d := range directions {
				nextX, nextY := curr.X+d.X, curr.Y+d.Y
				if nextX >= 0 && nextX < m && nextY >= 0 && nextY < n && forest[nextX][nextY] != 2 && fire[nextX][nextY] == -1 {
					fire[nextX][nextY] = fire[curr.X][curr.Y] + 1
					q = append(q, Point{nextX, nextY})
				}
			}
		}

		if fire[0][0] <= minutes {
			return false
		}

		q = []Point{{0, 0}}
		visited[0][0] = true
		time := 0

		for len(q) > 0 {
			curr := q[0]
			q = q[1:]

			if curr.X == m-1 && curr.Y == n-1{
				return true
			}

			for _, d := range directions {
				nextX, nextY := curr.X+d.X, curr.Y+d.Y
				if nextX >= 0 && nextX < m && nextY >= 0 && nextY < n && forest[nextX][nextY] != 2 && !visited[nextX][nextY] {
					delay := minutes
					if nextX == 0 && nextY == 0 {
						delay = 0
					}

					if fire[nextX][nextY] == -1 || fire[nextX][nextY] > time+1+delay {
						q = append(q, Point{nextX, nextY})
						visited[nextX][nextY] = true
					}
				}
			}
			time++
		}

		return false
	}

	left, right := 0, m*n
	ans := -1

	for left <= right {
		mid := left + (right-left)/2
		if canReach(mid) {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	if ans == m*n {
		return 1000000000
	}

	return ans
}