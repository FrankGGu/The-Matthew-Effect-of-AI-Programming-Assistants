func shortestBeautifulSubstring(s string, k int, target int) string {
	minBeautifulString := ""
	n := len(s)

	for i := 0; i <= n-k; i++ {
		sub := s[i : i+k]

		// 1. Check for leading zero (if k > 1)
		if k > 1 && sub[0] == '0' {
			continue
		}

		// 2. Check if palindrome
		isPalindrome := true
		for j := 0; j < k/2; j++ {
			if sub[j] != sub[k-1-j] {
				isPalindrome = false
				break
			}
		}
		if !isPalindrome {
			continue
		}

		// 3. Calculate sum of digits and check divisibility by target
		digitSum := 0
		for j := 0; j < k; j++ {
			digitSum += int(sub[j] - '0')
		}
		if digitSum%target != 0 {
			continue
		}

		// If all conditions met, it's a beautiful string
		// Compare with current minBeautifulString lexicographically
		if minBeautifulString == "" || sub < minBeautifulString {
			minBeautifulString = sub
		}
	}

	return minBeautifulString
}