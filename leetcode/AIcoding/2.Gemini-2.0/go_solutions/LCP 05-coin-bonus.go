func bonus(n int, edges [][]int, k int) int {
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0]-1, edge[1]-1
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	ans := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for l := j + 1; l < n; l++ {
				if contains(graph[i], j) && contains(graph[i], l) && contains(graph[j], l) {
					ans = max(ans, (i+1)*(j+1)*(l+1))
				}
			}
		}
	}

	if ans < k {
		return -1
	}
	return ans
}

func contains(arr []int, target int) bool {
	for _, num := range arr {
		if num == target {
			return true
		}
	}
	return false
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}