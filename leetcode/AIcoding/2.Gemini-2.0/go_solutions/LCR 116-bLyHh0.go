func findCircleNum(isConnected [][]int) int {
	n := len(isConnected)
	visited := make([]bool, n)
	count := 0
	var dfs func(int)
	dfs = func(node int) {
		visited[node] = true
		for i := 0; i < n; i++ {
			if isConnected[node][i] == 1 && !visited[i] {
				dfs(i)
			}
		}
	}

	for i := 0; i < n; i++ {
		if !visited[i] {
			dfs(i)
			count++
		}
	}
	return count
}