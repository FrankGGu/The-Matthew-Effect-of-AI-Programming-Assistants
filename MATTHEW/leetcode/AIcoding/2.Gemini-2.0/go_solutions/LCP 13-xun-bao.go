func minimalSteps(maze []string) int {
	m, n := len(maze), len(maze[0])
	var start, end []int
	var stones [][]int
	var boxes [][]int
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if maze[i][j] == 'S' {
				start = []int{i, j}
			} else if maze[i][j] == 'T' {
				end = []int{i, j}
			} else if maze[i][j] == 'O' {
				stones = append(stones, []int{i, j})
			} else if maze[i][j] == 'M' {
				boxes = append(boxes, []int{i, j})
			}
		}
	}
	k := len(boxes)
	dist := func(x1, y1, x2, y2 int) int {
		q := [][]int{{x1, y1, 0}}
		visited := make([][]bool, m)
		for i := 0; i < m; i++ {
			visited[i] = make([]bool, n)
		}
		visited[x1][y1] = true
		for len(q) > 0 {
			curr := q[0]
			q = q[1:]
			x, y, d := curr[0], curr[1], curr[2]
			if x == x2 && y == y2 {
				return d
			}
			dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
			for _, dir := range dirs {
				nx, ny := x+dir[0], y+dir[1]
				if nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] != '#' && !visited[nx][ny] {
					visited[nx][ny] = true
					q = append(q, []int{nx, ny, d + 1})
				}
			}
		}
		return -1
	}
	d := make([][]int, k+2)
	d[0] = make([]int, k+2)
	d[1] = make([]int, k+2)
	for i := 2; i < k+2; i++ {
		d[i] = make([]int, k+2)
	}
	b := append([][]int{start}, boxes...)
	b = append(b, end)
	for i := 0; i < k+1; i++ {
		for j := i + 1; j < k+2; j++ {
			minDist := -1
			for l := 0; l < len(stones); l++ {
				d1 := dist(b[i][0], b[i][1], stones[l][0], stones[l][1])
				d2 := dist(stones[l][0], stones[l][1], b[j][0], b[j][1])
				if d1 != -1 && d2 != -1 {
					if minDist == -1 || d1+d2 < minDist {
						minDist = d1 + d2
					}
				}
			}
			d[i][j] = minDist
			d[j][i] = minDist
		}
	}
	for i := 0; i < k+2; i++ {
		for j := 0; j < k+2; j++ {
			if d[i][j] == -1 {
				return -1
			}
		}
	}
	dp := make([][]int, 1<<(k+1))
	for i := 0; i < (1 << (k + 1)); i++ {
		dp[i] = make([]int, k+1)
		for j := 0; j < k+1; j++ {
			dp[i][j] = -1
		}
	}
	dp[1][0] = 0
	for mask := 1; mask < (1 << (k + 1)); mask++ {
		for i := 0; i < k+1; i++ {
			if (mask&(1<<i)) != 0 && dp[mask][i] != -1 {
				for j := 1; j < k+1; j++ {
					if (mask&(1<<j)) == 0 {
						newMask := mask | (1 << j)
						newDist := dp[mask][i] + d[i][j]
						if dp[newMask][j] == -1 || newDist < dp[newMask][j] {
							dp[newMask][j] = newDist
						}
					}
				}
			}
		}
	}
	ans := -1
	finalMask := (1 << (k + 1)) - 1
	for i := 0; i < k+1; i++ {
		if dp[finalMask][i] != -1 {
			val := dp[finalMask][i] + d[i][k+1]
			if ans == -1 || val < ans {
				ans = val
			}
		}
	}
	return ans
}