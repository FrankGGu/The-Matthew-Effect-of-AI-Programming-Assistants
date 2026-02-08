func findTheChild(n int, k int) int {
	if n == 1 {
		return 0
	}

	cycleLen := 2 * (n - 1)
	effectiveK := k % cycleLen

	if effectiveK < n {
		return effectiveK
	} else {
		// The ball is moving backwards from child n-1
		// It reached child n-1 at (n-1) seconds (or any multiple of cycleLen + (n-1))
		// The number of steps taken backwards from n-1 is effectiveK - (n-1)
		// So the current child is (n-1) - (effectiveK - (n-1))
		return n - 1 - (effectiveK - (n - 1))
	}
}