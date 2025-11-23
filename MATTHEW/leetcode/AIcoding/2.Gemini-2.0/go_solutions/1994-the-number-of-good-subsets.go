const MOD = 1000000007

func numberOfGoodSubsets(nums []int) int {
	primes := []int{2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
	mask := make([]int, 31)
	for i := 2; i <= 30; i++ {
		x := i
		for j, p := range primes {
			if x%p == 0 {
				if x%(p*p) == 0 {
					mask[i] = -1
					break
				}
				mask[i] |= (1 << j)
			}
		}
	}

	cnt := make([]int, 31)
	for _, num := range nums {
		cnt[num]++
	}

	dp := make([]int, 1<<10)
	dp[0] = 1

	for i := 2; i <= 30; i++ {
		if mask[i] == -1 {
			continue
		}
		c := cnt[i]
		if c == 0 {
			continue
		}
		for j := (1 << 10) - 1; j >= 0; j-- {
			if (j & mask[i]) == 0 {
				dp[j|mask[i]] = (dp[j|mask[i]] + (dp[j] * c) % MOD) % MOD
			}
		}
	}

	ans := 0
	for i := 1; i < (1 << 10); i++ {
		ans = (ans + dp[i]) % MOD
	}

	pow2 := 1
	for i := 0; i < cnt[1]; i++ {
		pow2 = (pow2 * 2) % MOD
	}

	ans = (ans * pow2) % MOD
	return ans
}