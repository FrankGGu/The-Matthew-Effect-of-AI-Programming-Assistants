const MOD = 1_000_000_007

func specialPermutations(nums []int) int {
	n := len(nums)
	dp := make([][]int, 1<<n)
	for i := range dp {
		dp[i] = make([]int, n)