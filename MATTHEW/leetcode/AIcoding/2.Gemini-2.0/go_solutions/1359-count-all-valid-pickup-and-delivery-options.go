func countOrders(n int) int {
	mod := 1000000007
	res := 1
	for i := 1; i <= n; i++ {
		res = (res * (2*i - 1) * i) % mod
	}
	return res
}