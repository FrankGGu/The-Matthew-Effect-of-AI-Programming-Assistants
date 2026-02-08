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

func maxProduct(s string) int {
	n := len(s)
	palindromeLengths := make(map[int]int)

	for i := 1; i < (1 << n); i++ {
		var sub []byte
		for j := 0; j < n; j++ {
			if (i >> j) & 1 == 1 {
				sub = append(sub, s[j])
			}
		}

		subStr := string(sub)
		if isPalindrome(subStr) {
			palindromeLengths[i] = len(subStr)
		}
	}

	maxProd := 0
	for mask1, len1 := range palindromeLengths {
		for mask2, len2 := range palindromeLengths {
			if (mask1 & mask2) == 0 {
				maxProd = max(maxProd, len1*len2)
			}
		}
	}

	return maxProd
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}