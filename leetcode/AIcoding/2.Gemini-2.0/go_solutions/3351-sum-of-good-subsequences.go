func sumOfGoodSubsequences(nums []int) int {
	const MOD = 1e9 + 7
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		if nums[i] == 1 {
			ans = (ans + 1) % MOD
		}
	}

	pow2 := make([]int, n+1)
	pow2[0] = 1
	for i := 1; i <= n; i++ {
		pow2[i] = (pow2[i-1] * 2) % MOD
	}

	return (ans * pow2[n-1]) % MOD
}