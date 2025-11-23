import (
	"strconv"
)

func kMirror(k int, n int) int64 {
	ans := int64(0)
	count := 0

	for length := 1; ; length++ {
		start := intPow(10, (length-1)/2)
		end := intPow(10, length/2)

		for i := start; i < end; i++ {
			num := createPalindrome(i, length%2 == 0)

			base10Str := strconv.FormatInt(num, 10)
			baseKStr := convertBase(num, k)

			if isPalindrome(baseKStr) {
				ans += num
				count++
				if count == n {
					return ans
				}
			}
		}

		if length > 10 {
			break
		}
	}
	return ans
}

func createPalindrome(num int64, even bool) int64 {
	s := strconv.FormatInt(num, 10)
	t := s
	if !even {
		t = t[:len(t)-1]
	}

	for i := len(t) - 1; i >= 0; i-- {
		s += string(t[i])
	}

	res, _ := strconv.ParseInt(s, 10, 64)
	return res
}

func convertBase(n int64, k int) string {
	if n == 0 {
		return "0"
	}
	s := ""
	for n > 0 {
		s = strconv.Itoa(int(n%int64(k))) + s
		n /= int64(k)
	}
	return s
}

func isPalindrome(s string) bool {
	for i := 0; i < len(s)/2; i++ {
		if s[i] != s[len(s)-i-1] {
			return false
		}
	}
	return true
}

func intPow(base, exponent int) int64 {
	result := int64(1)
	for i := 0; i < exponent; i++ {
		result *= int64(base)
	}
	return result
}