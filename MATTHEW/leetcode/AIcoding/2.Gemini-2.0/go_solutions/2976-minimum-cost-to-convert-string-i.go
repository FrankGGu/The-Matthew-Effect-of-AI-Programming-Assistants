func minimumCost(source string, target string, original []byte, changed []byte, cost []int) int64 {
	n := len(source)
	m := len(original)

	adj := make([][]int, 26)
	dist := make([][]int, 26)
	for i := 0; i < 26; i++ {
		adj[i] = make([]int, 26)
		dist[i] = make([]int, 26)
		for j := 0; j < 26; j++ {
			if i == j {
				dist[i][j] = 0
			} else {
				dist[i][j] = int(1e9 + 7)
			}
		}
	}

	for i := 0; i < m; i++ {
		u := int(original[i] - 'a')
		v := int(changed[i] - 'a')
		dist[u][v] = min(dist[u][v], cost[i])
	}

	for k := 0; k < 26; k++ {
		for i := 0; i < 26; i++ {
			for j := 0; j < 26; j++ {
				dist[i][j] = min(dist[i][j], dist[i][k]+dist[k][j])
			}
		}
	}

	ans := int64(0)
	for i := 0; i < n; i++ {
		if source[i] == target[i] {
			continue
		}
		u := int(source[i] - 'a')
		v := int(target[i] - 'a')
		if dist[u][v] == int(1e9+7) {
			return -1
		}
		ans += int64(dist[u][v])
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}