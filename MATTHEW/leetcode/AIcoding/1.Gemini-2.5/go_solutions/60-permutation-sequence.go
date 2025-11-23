func getPermutation(n int, k int) string {
	factorials := make([]int, n+1)
	factorials[0] = 1
	for i := 1; i <= n; i++ {
		factorials[i] =