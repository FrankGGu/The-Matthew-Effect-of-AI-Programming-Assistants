func mySqrt(x int) int {
	low := 0
	high := x
	ans := 0

	for low <= high {
		mid := low + (high-low)/2

		// To prevent overflow when calculating mid*mid,
		// we can cast mid to int64 before multiplication.
		// Alternatively,