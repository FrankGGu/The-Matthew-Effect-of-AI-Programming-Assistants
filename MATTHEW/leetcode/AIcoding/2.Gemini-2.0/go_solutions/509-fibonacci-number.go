func fib(n int) int {
	if n <= 1 {
		return n
	}
	a := 0
	b := 1
	for i := 2; i <= n; i++ {
		temp := a + b
		a = b
		b = temp
	}
	return b
}