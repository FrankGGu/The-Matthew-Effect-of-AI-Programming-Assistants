func countValidPaths(n int, edges [][]int) int64 {
	isPrime := func(x int) bool {
		if x < 2 {
			return false
		}
		for i := 2; i*i <= x; i++ {
			if x%i == 0 {
				return false
			}
		}
		return true
	}

	graph := make([][]int, n+1)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	var ans int64
	visited := make([]bool, n+1)

	var dfs func(node int, parent int) int
	dfs = func(node int, parent int) int {
		count := 1
		for _, neighbor := range graph[node] {
			if neighbor != parent && !isPrime(neighbor) {
				count += dfs(neighbor, node)
			}
		}
		return count
	}

	for i := 1; i <= n; i++ {
		if isPrime(i) {
			sum := 0
			for _, neighbor := range graph[i] {
				if !isPrime(neighbor) {
					count := dfs(neighbor, i)
					ans += int64(count)
					sum += count
				}
			}
			ans += int64(sum * (sum - 1) / 2)
		}
	}
	ans += int64(n) - int64(len(edges))
	return ans
}