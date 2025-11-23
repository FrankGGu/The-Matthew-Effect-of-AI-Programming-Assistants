package main

func removePalindromeSub(s string) int {
	if len(s) == 0 {
		return 0
	}
	isPalindrome := func(s string) bool {
		for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
			if s[i] != s[j] {
				return false
			}
		}
		return true
	}
	if isPalindrome(s) {
		return 1
	}
	return 2
}