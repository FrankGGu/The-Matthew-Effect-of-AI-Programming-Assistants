func minLength(s string) int {
	n := len(s)
	if n <= 1 {
		return n
	}

	counts := make([]int, 26)
	for i := 0; i < n; i++ {
		counts[s[i]-'a']++
	}

	oddCount := 0
	for i := 0; i < 26; i++ {
		if counts[i]%2 != 0 {
			oddCount++
		}
	}

	if oddCount > 1 {
		return n
	}

	l, r := 0, n-1
	for l < r && s[l] == s[r] {
		l++
		r--
	}

	if l >= r {
		return 0
	}

	return 2
}