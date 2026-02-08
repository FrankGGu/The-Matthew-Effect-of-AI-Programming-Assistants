import (
	"strconv"
)

func largestPalindrome(n int, k int) string {
	if n == 1 {
		if k > 3 {
			return "9"
		}
		return strconv.Itoa(9 % k)
	}

	upperBound := pow10(n) - 1
	lowerBound := pow10(n-1)

	for firstHalf := upperBound; firstHalf >= lowerBound; firstHalf-- {
		palindrome := createPalindrome(firstHalf)
		num, _ := strconv.Atoi(palindrome)
		if num%k == 0 {
			return palindrome
		}
	}

	return "-1"
}

func pow10(n int) int {
	result := 1
	for i := 0; i < n; i++ {
		result *= 10
	}
	return result
}

func createPalindrome(firstHalf int) string {
	s := strconv.Itoa(firstHalf)
	reversed := ""
	for i := len(s) - 1; i >= 0; i-- {
		reversed += string(s[i])
	}
	return s + reversed
}