func reorderedPowerOf2(n int) bool {
	nCounts := countDigits(n)

	// Iterate through powers of 2.
	// 2^0 to 2^29 cover numbers with up to 9 digits.
	// 2^30 = 1,073