func minimumScore(n int, edges [][]int, values []int) int {
	adj := make([][]int, n)
	for _, e := range edges {
		u, v := e[0], e[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	in := make([]int, n)
	out := make([]int, n)
	euler := make([]int, 0)
	xor := make([]int, n)
	timer := 0

	var dfs func(u, p int)
	dfs = func(u, p int) {
		in[u] = timer
		euler = append(euler, u)
		timer++
		xor[u] = values[u]
		if p != -1 {
			xor[u] ^= xor[p]
		}

		for _, v := range adj[u] {
			if v != p {
				dfs(v, u)
			}
		}

		out[u] = timer
		euler = append(euler, u)
		timer++
	}

	dfs(0, -1)

	ans := int(1e9 + 7)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			u, v := euler[2*i], euler[2*j]

			var a, b, c int
			if in[u] <= in[v] && out[v] <= out[u] {
				a = xor[v]
				b = xor[u] ^ xor[v]
				c = xor[0] ^ xor[u]
			} else if in[v] <= in[u] && out[u] <= out[v] {
				a = xor[u]
				b = xor[v] ^ xor[u]
				c = xor[0] ^ xor[v]
			} else {
				a = xor[u]
				b = xor[v]
				c = xor[0] ^ xor[u] ^ xor[v]
			}

			mn := min(a, min(b, c))
			mx := max(a, max(b, c))
			ans = min(ans, mx-mn)
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}