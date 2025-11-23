func countSubstrings(s string, t string) int {
	n := len(s)
	m := len(t)
	ans := 0
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			diff := 0
			for k := 0; i+k < n && j+k < m; k++ {
				if s[i+k] != t[j+k] {
					diff++
				}
				if diff == 1 {
					ans++
				} else if diff > 1 {
					break
				}
			}
		}
	}
	return ans
}