func shortestPalindrome(s string) string {
	n := len(s)
	if n <= 1 {
		return s
	}
	t := s + "#"
	for i := n - 1; i >= 0; i-- {
		t += string(s[i])
	}
	m := len(t)
	lps := make([]int, m)
	length := 0
	i := 1
	for i < m {
		if t[i] == t[length] {
			length++
			lps[i] = length
			i++
		} else {
			if length != 0 {
				length = lps[length-1]
			} else {
				lps[i] = 0
				i++
			}
		}
	}
	prefixLen := lps[m-1]
	suffix := s[prefixLen:]
	result := ""
	for i := len(suffix) - 1; i >= 0; i-- {
		result += string(suffix[i])
	}
	return result + s
}