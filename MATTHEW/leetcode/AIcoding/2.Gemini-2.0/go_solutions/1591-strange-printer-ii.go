func isPrintable(targetGrid [][]int) bool {
	m, n := len(targetGrid), len(targetGrid[0])
	colors := make(map[int][]int)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			color := targetGrid[i][j]
			if _, ok := colors[color]; !ok {
				colors[color] = []int{m, n, -1, -1}
			}
			colors[color][0] = min(colors[color][0], i)
			colors[color][1] = min(colors[color][1], j)
			colors[color][2] = max(colors[color][2], i)
			colors[color][3] = max(colors[color][3], j)
		}
	}

	graph := make(map[int][]int)
	indegree := make(map[int]int)

	for color := range colors {
		indegree[color] = 0
	}

	for color1 := range colors {
		for color2 := range colors {
			if color1 == color2 {
				continue
			}
			r1, c1, r2, c2 := colors[color1][0], colors[color1][1], colors[color1][2], colors[color1][3]
			r3, c3, r4, c4 := colors[color2][0], colors[color2][1], colors[color2][2], colors[color2][3]

			if r3 >= r1 && r4 >= c1 && r2 <= r1 && c4 <= c1 {
				continue
			}
			if r3 >= r1 && r4 >= c1 && r2 >= r1 && c4 <= c1 {
				continue
			}

			overlap := false
			for i := colors[color1][0]; i <= colors[color1][2]; i++ {
				for j := colors[color1][1]; j <= colors[color1][3]; j++ {
					if targetGrid[i][j] == color2 {
						overlap = true
						break
					}
				}
				if overlap {
					break
				}
			}

			if overlap {
				if _, ok := graph[color2]; !ok {
					graph[color2] = []int{}
				}
				graph[color2] = append(graph[color2], color1)
				indegree[color1]++
			}
		}
	}

	queue := []int{}
	for color := range indegree {
		if indegree[color] == 0 {
			queue = append(queue, color)
		}
	}

	count := 0
	for len(queue) > 0 {
		color := queue[0]
		queue = queue[1:]
		count++

		for _, neighbor := range graph[color] {
			indegree[neighbor]--
			if indegree[neighbor] == 0 {
				queue = append(queue, neighbor)
			}
		}
	}

	return count == len(colors)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}