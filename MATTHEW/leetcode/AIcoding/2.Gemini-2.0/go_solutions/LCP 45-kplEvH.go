func isPossible(position [][]int, bikes int) bool {
	n := len(position)
	dist := make([][]int, n)
	for i := 0; i < n; i++ {
		dist[i] = make([]int, n)
		for j := 0; j < n; j++ {
			dist[i][j] = (position[i][0]-position[j][0])*(position[i][0]-position[j][0]) + (position[i][1]-position[j][1])*(position[i][1]-position[j][1])
		}
	}

	lo, hi := 0, 40000
	for lo < hi {
		mid := lo + (hi-lo)/2
		count := 0
		visited := make([]bool, n)
		var dfs func(int) bool
		dfs = func(u int) bool {
			if visited[u] {
				return false
			}
			visited[u] = true
			for v := 0; v < n; v++ {
				if dist[u][v] <= mid*mid {
					if count < bikes-1 || u != v {
						count++
						return true
					}
					count--
				}
			}
			visited[u] = false
			return false
		}

		possible := true
		for i := 0; i < n; i++ {
			count = 0
			visited = make([]bool, n)
			if !dfs(i) {
				possible = false
				break
			}
		}

		if possible {
			hi = mid
		} else {
			lo = mid + 1
		}
	}
	return lo
}