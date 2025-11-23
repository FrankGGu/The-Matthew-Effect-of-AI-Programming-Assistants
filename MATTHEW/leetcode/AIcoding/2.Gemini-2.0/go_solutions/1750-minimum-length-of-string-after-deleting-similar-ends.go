func minimumLength(s string) int {
	l, r := 0, len(s)-1
	for l < r && s[l] == s[r] {
		ch := s[l]
		for l <= r && s[l] == ch {
			l++
		}
		for l <= r && s[r] == ch {
			r--
		}
	}
	return r - l + 1
}