func maxProduct(s string) int {
	n := len(s)
	maxLen := make([]int, n)
	for i := 0; i < n; i++ {
		maxLen[i] = 1
	}

	for i := 0; i < n; i++ {
		// Odd length palindromes
		l, r := i-1, i+1
		for l >= 0 && r < n && s[l] == s[r] {
			maxLen[r] = max(maxLen[r], r-l+1)
			l--
			r++
		}

		// Even length palindromes
		l, r := i, i+1
		for l >= 0 && r < n && s[l] == s[r] {
			maxLen[r] = max(maxLen[r], r-l+1)
			l--
			r++
		}
	}

	leftMax := make([]int, n)
	leftMax[0] = maxLen[0]
	for i := 1; i < n; i++ {
		leftMax[i] = max(leftMax[i-1], maxLen[i])
	}

	reverseS := reverseString(s)
	reverseMaxLen := make([]int, n)
	for i := 0; i < n; i++ {
		reverseMaxLen[i] = 1
	}

	for i := 0; i < n; i++ {
		// Odd length palindromes
		l, r := i-1, i+1
		for l >= 0 && r < n && reverseS[l] == reverseS[r] {
			reverseMaxLen[r] = max(reverseMaxLen[r], r-l+1)
			l--
			r++
		}

		// Even length palindromes
		l, r := i, i+1
		for l >= 0 && r < n && reverseS[l] == reverseS[r] {
			reverseMaxLen[r] = max(reverseMaxLen[r], r-l+1)
			l--
			r++
		}
	}

	rightMax := make([]int, n)
	rightMax[0] = reverseMaxLen[0]
	for i := 1; i < n; i++ {
		rightMax[i] = max(rightMax[i-1], reverseMaxLen[i])
	}

	result := 0
	for i := 0; i < n-1; i++ {
		result = max(result, leftMax[i]*rightMax[n-2-i])
	}

	return result
}

func reverseString(s string) string {
	runes := []rune(s)
	for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
		runes[i], runes[j] = runes[j], runes[i]
	}
	return string(runes)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}