import (
	"math"
	"strconv"
)

func beautifulPartitions(s string, k int, minLength int) int {
	n := len(s)
	dp := make([]int, n+1)
	dp[n] = 1
	primes := []byte{'2', '3', '5', '7'}
	isPrime := func(c byte) bool {
		for _, p := range primes {
			if c == p {
				return true
			}
		}
		return false
	}

	if !isPrime(s[0]) {
		return 0
	}

	for i := n - 1; i >= 0; i-- {
		if !isPrime(s[i]) {
			dp[i] = 0
			continue
		}
		for j := i + minLength; j <= n; j++ {
			if j < n && !isPrime(s[j]) {
				continue
			}
			num, _ := strconv.Atoi(s[i:j])
			if num >= k && num <= 9999 {
				dp[i] = (dp[i] + dp[j]) % 1000000007
			}
		}
	}

	return dp[0]
}

func isBeautiful(s string) bool {
	num, _ := strconv.Atoi(s)
	if num == 0 {
		return false
	}
	if num == 1 {
		return true
	}
	for num%5 == 0 {
		num /= 5
	}
	for num%3 == 0 {
		num /= 3
	}
	for num%2 == 0 {
		num /= 2
	}
	return num == 1
}

func minBeautifulPartitions(s string) int {
	n := len(s)
	dp := make([]int, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for i := 1; i <= n; i++ {
		for j := 1; j <= i; j++ {
			sub := s[i-j : i]
			if isBeautiful(sub) && dp[i-j] != math.MaxInt32 {
				dp[i] = min(dp[i], dp[i-j]+1)
			}
		}
	}

	if dp[n] == math.MaxInt32 {
		return -1
	}
	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}