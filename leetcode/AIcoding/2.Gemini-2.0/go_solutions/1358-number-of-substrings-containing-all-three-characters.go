func numberOfSubstrings(s string) int {
	count := 0
	n := len(s)
	for i := 0; i < n; i++ {
		a, b, c := 0, 0, 0
		for j := i; j < n; j++ {
			if s[j] == 'a' {
				a++
			} else if s[j] == 'b' {
				b++
			} else {
				c++
			}
			if a > 0 && b > 0 && c > 0 {
				count += n - j
				break
			}
		}
	}
	return count
}