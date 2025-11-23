func sumScores(s string) int64 {
	n := len(s)
	z := make([]int, n)
	l, r := 0, 0
	for i := 1; i < n; i++ {
		if i <= r {
			z[i] = min(r-i+1, z[i-l])
		}
		for i+z[i] < n && s[z[i]] == s[i+z[i]] {
			z[i]++
		}
		if i+z[i]-1 > r {
			l = i
			r = i + z[i] - 1
		}
	}
	z[0] = n
	var ans int64 = 0
	for i := 0; i < n; i++ {
		ans += int64(z[i])
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}