func countSubstrings(s string, t string) int {
	n := len(s)
	m := len(t)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := s[i : j+1]
			if len(sub) != len(t) {
				continue
			}
			diff := 0
			for k := 0; k < len(sub); k++ {
				if sub[k] != t[k] {
					diff++
				}
			}
			if diff <= 1 {
				ans++
			}
		}
	}
	return ans
}