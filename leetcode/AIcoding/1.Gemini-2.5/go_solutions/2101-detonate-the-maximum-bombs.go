package main

func maximumDetonation(bombs [][]int) int {
	n := len(bombs)
	if n == 0 {
		return 0
	}

	adj := make([][]int, n)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}

			x1, y1, r1 := bombs[i][0], bombs[i][1], bombs[i][2]
			x2, y2, _ := bombs[j][0], bombs[j][1], bombs[j][2]

			dx := int64(x1 - x2)
			dy := int64(y1 - y2)
			distSq := dx*dx + dy*dy
			r1Sq := int64(r1) * int64(r1)

			if distSq <= r1Sq {
				adj[i] = append(adj[i], j)
			}
		}
	}

	maxBombs := 0

	for i := 0; i < n; i++ {
		visited := make([]bool, n)
		currentCount := 0

		var dfs func(node int)
		dfs = func(node int) {
			visited[node] = true
			currentCount++
			for _, neighbor := range adj[node] {
				if !visited[neighbor] {
					dfs(neighbor)
				}
			}
		}

		dfs(i)
		if currentCount > maxBombs {
			maxBombs = currentCount
		}
	}

	return maxBombs
}