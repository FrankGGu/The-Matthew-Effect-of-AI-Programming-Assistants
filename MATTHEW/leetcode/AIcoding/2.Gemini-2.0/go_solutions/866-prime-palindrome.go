import (
	"math"
	"strconv"
)

func primePalindrome(n int) int {
	if n >= 8 && n <= 11 {
		return 11
	}
	for i := 1; i <= 100000; i++ {
		s := strconv.Itoa(i)
		t := ""
		for j := len(s) - 2; j >= 0; j-- {
			t += string(s[j])
		}
		p := s + t
		num, _ := strconv.Atoi(p)
		if num >= n && isPrime(num) {
			return num
		}
	}
	return -1
}

func isPrime(n int) bool {
	if n <= 1 {
		return false
	}
	for i := 2; i <= int(math.Sqrt(float64(n))); i++ {
		if n%i == 0 {
			return false
		}
	}
	return true
}