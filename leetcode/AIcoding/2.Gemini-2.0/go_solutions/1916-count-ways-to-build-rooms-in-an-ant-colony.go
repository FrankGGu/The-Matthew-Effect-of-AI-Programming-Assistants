func countWays(parents []int) int {
	n := len(parents)
	children := make([][]int, n)
	for i := 1; i < n; i++ {
		children[parents[i]] = append(children[parents[i]], i)
	}

	size := make([]int, n)
	var dfs func(int)
	dfs = func(node int) {
		size[node] = 1
		for _, child := range children[node] {
			dfs(child)
			size[node] += size[child]
		}
	}
	dfs(0)

	fact := make([]int, n+1)
	fact[0] = 1
	for i := 1; i <= n; i++ {
		fact[i] = (fact[i-1] * i) % 1000000007
	}

	pow := func(a, b int) int {
		res := 1
		a %= 1000000007
		for b > 0 {
			if b%2 == 1 {
				res = (res * a) % 1000000007
			}
			a = (a * a) % 1000000007
			b /= 2
		}
		return res
	}

	inv := func(n int) int {
		return pow(n, 1000000007-2)
	}

	res := 1
	for i := 0; i < n; i++ {
		if len(children[i]) > 0 {
			res = (res * fact[size[i]-1]) % 1000000007
		}
	}

	ans := fact[n-1]
	ans = (ans * inv(res)) % 1000000007

	return ans
}