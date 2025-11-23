func crackSafe(n int, k int) string {
	if n == 1 && k == 1 {
		return "0"
	}
	total := int(math.Pow(float64(k), float64(n)))
	ans := strings.Repeat("0", n-1)
	seen := make(map[string]bool)
	seen[ans] = true
	for i := 0; i < total; i++ {
		prefix := ans[len(ans)-n+1:]
		for j := k - 1; j >= 0; j-- {
			next := prefix + strconv.Itoa(j)
			if !seen[next] {
				ans += strconv.Itoa(j)
				seen[next] = true
				break
			}
		}
	}
	return ans
}