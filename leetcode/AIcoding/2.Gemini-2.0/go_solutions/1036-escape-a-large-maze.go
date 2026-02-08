func isEscapePossible(blocked [][]int, source []int, target []int) bool {
	blockedSet := make(map[int]map[int]bool)
	for _, block := range blocked {
		if _, ok := blockedSet[block[0]]; !ok {
			blockedSet[block[0]] = make(map[int]bool)
		}
		blockedSet[block[0]][block[1]] = true
	}

	maxArea := len(blocked) * (len(blocked) - 1) / 2

	var bfs func([]int, []int) bool
	bfs = func(start []int, end []int) bool {
		visited := make(map[int]map[int]bool)
		queue := [][]int{start}
		visited[start[0]] = map[int]bool{start[1]: true}
		count := 0

		directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

		for len(queue) > 0 {
			curr := queue[0]
			queue = queue[1:]
			count++

			if curr[0] == end[0] && curr[1] == end[1] {
				return true
			}

			if count > maxArea {
				return true
			}

			for _, dir := range directions {
				nextX := curr[0] + dir[0]
				nextY := curr[1] + dir[1]

				if nextX >= 0 && nextX < 1000000 && nextY >= 0 && nextY < 1000000 {
					if _, ok := blockedSet[nextX]; ok {
						if _, ok := blockedSet[nextX][nextY]; ok {
							continue
						}
					}

					if _, ok := visited[nextX]; ok {
						if _, ok := visited[nextX][nextY]; ok {
							continue
						}
					} else {
						visited[nextX] = make(map[int]bool)
					}

					visited[nextX][nextY] = true
					queue = append(queue, []int{nextX, nextY})
				}
			}
		}

		return false
	}

	return bfs(source, target) && bfs(target, source)
}