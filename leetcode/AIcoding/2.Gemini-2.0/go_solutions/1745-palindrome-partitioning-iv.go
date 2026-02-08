func canPartition(s string) bool {
	n := len(s)
	if n < 3 {
		return false
	}

	isPalindrome := make([][]bool, n)
	for i := range isPalindrome {
		isPalindrome[i] = make([]bool, n)
	}

	for i := 0; i < n; i++ {
		isPalindrome[i][i] = true
	}

	for i := 0; i < n-1; i++ {
		if s[i] == s[i+1] {
			isPalindrome[i][i+1] = true
		}
	}

	for length := 3; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] == s[j] && isPalindrome[i+1][j-1] {
				isPalindrome[i][j] = true
			}
		}
	}

	for i := 0; i < n-2; i++ {
		if isPalindrome[0][i] {
			for j := i + 1; j < n-1; j++ {
				if isPalindrome[i+1][j] && isPalindrome[j+1][n-1] {
					return true
				}
			}
		}
	}

	return false
}