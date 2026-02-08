func minCut(s string) int {
	n := len(s)
	if n <= 1 {
		return 0
	}

	isPalindrome := make([][]bool, n)
	for i := range isPalindrome {
		isPalindrome[i] = make([]bool, n)
	}

	for length := 1; length <= n; length++ {
		for start := 0; start <= n-length; start++ {
			end := start + length - 1
			if s[start] == s[end] && (length <= 2 || isPalindrome[start+1][end-1]) {
				isPalindrome[start][end] = true
			}
		}
	}

	cuts := make([]int, n)
	for i := 0; i < n; i++ {
		if isPalindrome[0][i] {
			cuts[i] = 0
		} else {
			minCut := n
			for j := 0; j < i; j++ {
				if isPalindrome[j+1][i] {
					minCut = min(minCut, cuts[j]+1)
				}
			}
			cuts[i] = minCut
		}
	}
	return cuts[n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}