import "math"

func nthSuperUglyNumber(n int, primes []int) int {
	dp := make([]int, n)
	dp[0] = 1

	k := len(primes)
	pointers := make([]int, k) // pointers[j] stores the index in dp for primes[j]
	nextMulti