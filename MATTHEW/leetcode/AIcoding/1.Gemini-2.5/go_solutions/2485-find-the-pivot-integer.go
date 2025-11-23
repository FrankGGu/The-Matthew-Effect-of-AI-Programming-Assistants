func pivotInteger(n int) int {
	totalSum := n * (n + 1) / 2

	// Calculate the square root of the total sum.
	// If totalSum is a perfect square, its integer square root will be the pivot.
	xFloat := math.Sqrt(float64(totalSum))

	// Convert the float64 square root to an integer.
	xInt := int(xFloat)

	// Check if xInt is indeed the integer square root of totalSum.
	// This means totalSum must be a perfect square.
	if xInt*xInt == totalSum {
		return xInt
	}

	// If totalSum is not a perfect square, no such integer pivot exists.
	return -1
}