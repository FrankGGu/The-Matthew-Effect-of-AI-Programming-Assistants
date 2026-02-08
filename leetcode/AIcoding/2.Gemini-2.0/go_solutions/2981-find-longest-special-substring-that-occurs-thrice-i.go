func longestSpecialSubstring(s string) int {
	n := len(s)
	ans := -1
	for i := 1; i <= n/3; i++ {
		count := make(map[string]int)
		for j := 0; j <= n-i; j++ {
			sub := s[j : j+i]
			isSpecial := true
			for k := 1; k < i; k++ {
				if sub[k] != sub[0] {
					isSpecial = false
					break
				}
			}
			if isSpecial {
				count[sub]++
			}
		}
		for _, c := range count {
			if c >= 3 {
				ans = i
				break
			}
		}
	}
	return ans
}