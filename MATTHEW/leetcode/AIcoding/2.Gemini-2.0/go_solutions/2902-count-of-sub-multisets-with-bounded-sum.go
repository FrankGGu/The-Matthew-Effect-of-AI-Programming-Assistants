func countSubMultisets(nums []int, l int, r int) int {
	const mod = 1000000007
	cnt := make(map[int]int)
	for _, x := range nums {
		cnt[x]++
	}
	zero := cnt[0]
	delete(cnt, 0)
	dp := make([]int, r+1)
	dp[0] = 1
	for x, c := range cnt {
		for j := x; j <= r; j++ {
			for k := 1; k <= c && j >= k*x; k++ {
				dp[j] = (dp[j] + dp[j-k*x]) % mod
			}
		}
	}

	ans := 0
	pow2 := 1
	for i := 0; i <= zero; i++ {
		for j := l; j <= r; j++ {
			ans = (ans + dp[j]) % mod
		}
		pow2 = (pow2 * 2) % mod
	}
	return ans
}