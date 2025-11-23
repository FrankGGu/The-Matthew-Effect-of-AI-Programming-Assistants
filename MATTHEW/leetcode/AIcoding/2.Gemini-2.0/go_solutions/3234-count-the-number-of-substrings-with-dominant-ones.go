func countSubstrings(s string) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		ones := 0
		zeros := 0
		for j := i; j < n; j++ {
			if s[j] == '1' {
				ones++
			} else {
				zeros++
			}
			if ones > zeros {
				ans++
			}
		}
	}
	return ans
}