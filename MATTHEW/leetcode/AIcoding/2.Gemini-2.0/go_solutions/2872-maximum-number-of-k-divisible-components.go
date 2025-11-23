func maxKDivisibleComponents(n int, edges [][]int, k int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	visited := make([]bool, n)
	count := 0

	var dfs func(int) int
	dfs = func(node int) int {
		visited[node] = true
		sum := 1
		for _, neighbor := range adj[node] {
			if !visited[neighbor] {
				sum += dfs(neighbor)
			}
		}
		if sum%k == 0 {
			count++
		}
		return sum % k
	}

	for i := 0; i < n; i++ {
		if !visited[i] {
			dfs(i)
		}
	}

	return count
}