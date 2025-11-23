func concatenatedBinary(n int) int {
	MOD := 1000000007
	ans := 0
	length := 0
	for i := 1; i <= n; i++ {
		if (i & (i - 1)) == 0 {
			length++
		}
		ans = ((ans << length) % MOD + i) % MOD
	}
	return ans
}