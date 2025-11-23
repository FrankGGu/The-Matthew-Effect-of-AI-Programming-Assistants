import (
	"math"
	"strconv"
)

func sumOfMaxPrimeSubstrings(s string) int {
	n := len(s)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := s[i : j+1]
			num, _ := strconv.Atoi(sub)
			if num <= 1000 && isPrime(num) {
				ans += num
			}
		}
	}
	return ans
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