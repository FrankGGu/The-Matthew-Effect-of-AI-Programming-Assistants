func countPalindromePaths(parent []int, s string) int {
	n := len(parent)
	adj := make([][]int, n)
	for i := 1; i < n; i++ {
		adj[parent[i]] = append(adj[parent[i]], i)
	}

	count := 0
	var dfs func(int, int)
	dfs = func(node int, mask int) {
		mask ^= (1 << (s[node] - 'a'))
		for i := 0; i < 26; i++ {
			count += masks[mask^(1<<i)]
		}
		count += masks[mask]
		masks[mask]++
		for _, neighbor := range adj[node] {
			dfs(neighbor, mask)
		}
		masks[mask]--
	}

	masks := make([]int, 1<<26)
	dfs(0, 0)

	return count
}