func crackSafe(n int, k int) string {
	if n == 1 && k == 1 {
		return "0"
	}

	total := pow(k, n)
	visited := make(map[string]bool)
	start := ""
	for i := 0; i < n-1; i++ {
		start += "0"
	}

	result := ""
	for i := 0; i < n-1; i++ {
		result += "0"
	}

	var dfs func(string)
	dfs = func(node string) {
		for i := 0; i < k; i++ {
			next := node + string(rune('0'+i))
			if !visited[next] {
				visited[next] = true
				dfs(next[1:])
				result += string(rune('0' + i))
			}
		}
	}

	dfs(start)

	return result
}

func pow(base, exp int) int {
	res := 1
	for i := 0; i < exp; i++ {
		res *= base
	}
	return res
}