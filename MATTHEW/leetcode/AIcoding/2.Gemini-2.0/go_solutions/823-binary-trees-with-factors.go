func numFactoredBinaryTrees(arr []int) int {
	sort.Ints(arr)
	n := len(arr)
	dp := make(map[int]int)
	mod := 1000000007
	for i := 0; i < n; i++ {
		dp[arr[i]] = 1
		for j := 0; j < i; j++ {
			if arr[i]%arr[j] == 0 {
				factor := arr[i] / arr[j]
				if _, ok := dp[factor]; ok {
					dp[arr[i]] = (dp[arr[i]] + dp[arr[j]]*dp[factor]) % mod
				}
			}
		}
	}
	ans := 0
	for _, v := range dp {
		ans = (ans + v) % mod
	}
	return ans
}