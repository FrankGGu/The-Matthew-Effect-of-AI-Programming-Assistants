func peopleAwareOfSecret(n int, delay int, forget int) int {
	dp := make([]int, n)
	dp[0] = 1
	mod := 1000000007
	shares := 0
	for i := 1; i < n; i++ {
		shares = 0
		for j := 0; j < i; j++ {
			if i-j >= delay && i-j < forget {
				shares = (shares + dp[j]) % mod
			}
		}
		dp[i] = shares
	}

	ans := 0
	for i := n - forget; i < n; i++ {
		if i >= 0 {
			ans = (ans + dp[i]) % mod
		}
	}
	if n < forget {
		for i :=0; i < n; i++ {
			ans = (ans + dp[i]) % mod
		}
	}
	return ans
}