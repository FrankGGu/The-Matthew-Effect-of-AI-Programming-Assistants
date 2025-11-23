func pivotInteger(n int) int {
	sum := n * (n + 1) / 2
	leftSum := 0
	for i := 1; i <= n; i++ {
		leftSum += i
		if leftSum == sum {
			return i
		}
		sum -= i
	}
	return -1
}