func squareFreeSubsets(nums []int) int {
	primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
	good := []bool{true, true, true, true, false, true, true, true, false, true, false, true, true, true, false, false, true, false, true, false, true, true, false, true, false, false, false, true, false, true}
	mod := 1000000007
	dp := make([]int, 1<<10)
	dp[0] = 1
	for _, num := range nums {
		if !good[num-1] {
			continue
		}
		mask := 0
		temp := num
		for i, prime := range primes {
			for temp%prime == 0 {
				mask |= (1 << i)
				temp /= prime
			}
		}
		for i := (1 << 10) - 1; i >= 0; i-- {
			if (i & mask) == 0 {
				dp[i|mask] = (dp[i|mask] + dp[i]) % mod
			}
		}
	}
	ans := 0
	for _, val := range dp {
		ans = (ans + val) % mod
	}
	return (ans - 1 + mod) % mod
}