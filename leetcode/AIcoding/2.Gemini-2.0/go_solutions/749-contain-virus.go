func containVirus(isInfected [][]int) int {
	m, n := len(isInfected), len(isInfected[0])
	ans := 0
	for {
		regions := []map[[2]int]bool{}
		borders := []int{}
		visited := make([][]bool, m)
		for i := range visited {
			visited[i] = make([]bool, n)
		}
		for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
				if isInfected[i][j] == 1 && !visited[i][j] {
					region := map[[2]int]bool{}
					border := 0
					q := [][2]int{{i, j}}
					visited[i][j] = true
					region[[2]int{i, j}] = true
					for len(q) > 0 {
						curr := q[0]
						q = q[1:]
						r, c := curr[0], curr[1]
						dirs := [][2]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
						for _, dir := range dirs {
							nr, nc := r+dir[0], c+dir[1]
							if nr >= 0 && nr < m && nc >= 0 && nc < n {
								if isInfected[nr][nc] == 1 && !visited[nr][nc] {
									visited[nr][nc] = true
									region[[2]int{nr, nc}] = true
									q = append(q, [2]int{nr, nc})
								} else if isInfected[nr][nc] == 0 {
									border++
								}
							}
						}
					}
					regions = append(regions, region)
					borders = append(borders, border)
				}
			}
		}

		if len(regions) == 0 {
			break
		}

		maxSpread := 0
		maxIndex := -1
		for i := 0; i < len(regions); i++ {
			spread := 0
			visited := make([][]bool, m)
			for i := range visited {
				visited[i] = make([]bool, n)
			}

			for coord := range regions[i] {
				r, c := coord[0], coord[1]
				dirs := [][2]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
				for _, dir := range dirs {
					nr, nc := r+dir[0], c+dir[1]
					if nr >= 0 && nr < m && nc >= 0 && nc < n && isInfected[nr][nc] == 0 && !visited[nr][nc] {
						visited[nr][nc] = true
						spread++
					}
				}
			}
			if spread > maxSpread {
				maxSpread = spread
				maxIndex = i
			}
		}

		if maxIndex == -1 {
			break
		}

		ans += borders[maxIndex]

		for i := 0; i < len(regions); i++ {
			if i == maxIndex {
				for coord := range regions[i] {
					isInfected[coord[0]][coord[1]] = -1
				}
			} else {
				visited := make([][]bool, m)
				for i := range visited {
					visited[i] = make([]bool, n)
				}
				for coord := range regions[i] {
					r, c := coord[0], coord[1]
					dirs := [][2]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
					for _, dir := range dirs {
						nr, nc := r+dir[0], c+dir[1]
						if nr >= 0 && nr < m && nc >= 0 && nc < n && isInfected[nr][nc] == 0 && !visited[nr][nc] {
							isInfected[nr][nc] = 1
							visited[nr][nc] = true
						}
					}
				}
			}
		}

		allContained := true
		for i := 0; i < m; i++ {
			for j := 0; j < n; j++ {
				if isInfected[i][j] == 1 {
					allContained = false
					break
				}
			}
			if !allContained {
				break
			}
		}
		if allContained {
			break
		}
	}

	return ans
}