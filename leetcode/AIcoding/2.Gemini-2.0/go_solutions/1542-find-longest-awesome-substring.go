func longestAwesome(s string) int {
	n := len(s)
	prefix := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefix[i+1] = prefix[i] ^ (1 << (s[i] - '0'))
	}

	first := make([]int, 1024)
	for i := range first {
		first[i] = n + 1
	}
	first[0] = 0

	ans := 0
	for i := 1; i <= n; i++ {
		ans = max(ans, i-first[prefix[i]])
		for j := 0; j < 10; j++ {
			mask := prefix[i] ^ (1 << j)
			ans = max(ans, i-first[mask])
		}
		first[prefix[i]] = min(first[prefix[i]], i)
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}