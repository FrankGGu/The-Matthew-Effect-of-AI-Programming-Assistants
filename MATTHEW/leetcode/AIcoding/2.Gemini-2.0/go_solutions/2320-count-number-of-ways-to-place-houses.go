func countHousePlacements(n int) int {
	mod := 1000000007
	a := 1
	b := 1
	for i := 1; i <= n; i++ {
		temp := b
		b = (a + b) % mod
		a = temp
	}
	return (b * b) % mod
}