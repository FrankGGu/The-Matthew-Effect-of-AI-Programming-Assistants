func longestCycle(n int, edges []int) int {
	ans := -1
	visited := make([]bool, n)
	for i := 0; i < n; i++ {
		if visited[i] {
			continue
		}
		path := make(map[int]int)
		curr := i
		dist := 0
		for curr != -1 && !visited[curr] {
			visited[curr] = true
			path[curr] = dist
			dist++
			curr = edges[curr]
		}
		if curr != -1 && _, ok := path[curr]; ok {
			ans = max(ans, dist-path[curr])
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}