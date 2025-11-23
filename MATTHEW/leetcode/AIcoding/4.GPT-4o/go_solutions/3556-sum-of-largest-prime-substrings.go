import (
	"strconv"
	"unicode"
)

func isPrime(n int) bool {
	if n <= 1 {
		return false
	}
	for i := 2; i*i <= n; i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func sumOfLargestPrimeSubstrings(s string) int {
	maxPrime := 0
	n := len(s)

	for i := 0; i < n; i++ {
		if unicode.IsDigit(rune(s[i])) {
			for j := i + 1; j <= n; j++ {
				subStr := s[i:j]
				if j-i > 0 && isPrime(convertToInt(subStr)) {
					if prime := convertToInt(subStr); prime > maxPrime {
						maxPrime = prime
					}
				}
				if j < n && !unicode.IsDigit(rune(s[j])) {
					break
				}
			}
		}
	}
	return maxPrime
}

func convertToInt(s string) int {
	num, _ := strconv.Atoi(s)
	return num
}