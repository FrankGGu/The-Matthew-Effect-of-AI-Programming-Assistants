func smallestSubstring(s string) string {
	n := len(s)
	ans := ""
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := s[i : j+1]
			valid := true
			for k := 0; k < len(sub); k++ {
				count := 0
				for l := 0; l < len(sub); l++ {
					if sub[l] == sub[k] {
						count++
					}
				}
				if count < 2 {
					valid = false
					break
				}
			}
			if valid {
				if ans == "" || len(sub) < len(ans) {
					ans = sub
				}
			}
		}
	}
	return ans
}