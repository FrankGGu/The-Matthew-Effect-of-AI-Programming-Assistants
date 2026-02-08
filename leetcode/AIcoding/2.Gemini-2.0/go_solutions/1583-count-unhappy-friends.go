func unhappyFriends(n int, preferences [][]int, pairs [][]int) int {
	adj := make([][]int, n)
	for i := 0; i < n; i++ {
		adj[i] = make([]int, n)
		for j, p := range preferences[i] {
			adj[i][p] = j
		}
	}

	match := make([]int, n)
	for _, p := range pairs {
		match[p[0]] = p[1]
		match[p[1]] = p[0]
	}

	unhappy := 0
	for x := 0; x < n; x++ {
		for y := 0; y < adj[x][match[x]]; y++ {
			u := preferences[x][y]
			if adj[u][x] < adj[u][match[u]] {
				unhappy++
				break
			}
		}
	}

	return unhappy
}