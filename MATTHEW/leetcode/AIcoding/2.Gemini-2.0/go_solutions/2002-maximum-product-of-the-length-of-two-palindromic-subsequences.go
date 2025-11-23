func maxProduct(s string) int {
	n := len(s)
	maxProd := 0
	for i := 0; i < (1 << n); i++ {
		s1 := ""
		s2 := ""
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				s1 += string(s[j])
			} else {
				s2 += string(s[j])
			}
		}
		if isPalindrome(s1) && isPalindrome(s2) {
			maxProd = max(maxProd, len(s1)*len(s2))
		}
	}
	return maxProd
}

func isPalindrome(s string) bool {
	l, r := 0, len(s)-1
	for l < r {
		if s[l] != s[r] {
			return false
		}
		l++
		r--
	}
	return true
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}