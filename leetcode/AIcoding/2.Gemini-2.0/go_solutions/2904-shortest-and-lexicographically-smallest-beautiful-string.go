func shortestBeautifulSubstring(s string, k int) string {
	n := len(s)
	ans := ""
	minLen := n + 1

	for i := 0; i < n; i++ {
		count := 0
		for j := i; j < n; j++ {
			if s[j] == '1' {
				count++
			}
			if count == k {
				length := j - i + 1
				sub := s[i : j+1]
				if length < minLen {
					minLen = length
					ans = sub
				} else if length == minLen && (ans == "" || sub < ans) {
					ans = sub
				}
				break
			}
		}
	}

	return ans
}