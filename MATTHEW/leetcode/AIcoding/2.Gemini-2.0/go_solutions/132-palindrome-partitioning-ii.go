func minCut(s string) int {
	n := len(s)
	isPalindrome := make([][]bool, n)
	for i := range isPalindrome {
		isPalindrome[i] = make([]bool, n)
	}

	for i := 0; i < n; i++ {
		isPalindrome[i][i] = true
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if length == 2 {
				isPalindrome[i][j] = (s[i] == s[j])
			} else {
				isPalindrome[i][j] = (s[i] == s[j] && isPalindrome[i+1][j-1])
			}
		}
	}

	cuts := make([]int, n)
	for i := 0; i < n; i++ {
		if isPalindrome[0][i] {
			cuts[i] = 0
		} else {
			cuts[i] = i
			for j := 0; j < i; j++ {
				if isPalindrome[j+1][i] && cuts[j]+1 < cuts[i] {
					cuts[i] = cuts[j] + 1
				}
			}
		}
	}

	return cuts[n-1]
}