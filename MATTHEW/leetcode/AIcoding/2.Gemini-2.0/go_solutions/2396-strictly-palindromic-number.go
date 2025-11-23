import (
	"strconv"
)

func isStrictlyPalindromic(n int) bool {
	if n < 4 {
		return false
	}
	for base := 2; base <= n-2; base++ {
		s := convertToBase(n, base)
		if !isPalindrome(s) {
			return false
		}
	}
	return true
}

func convertToBase(n int, base int) string {
	if n == 0 {
		return "0"
	}
	result := ""
	for n > 0 {
		rem := n % base
		result = strconv.Itoa(rem) + result
		n /= base
	}
	return result
}

func isPalindrome(s string) bool {
	left := 0
	right := len(s) - 1
	for left < right {
		if s[left] != s[right] {
			return false
		}
		left++
		right--
	}
	return true
}