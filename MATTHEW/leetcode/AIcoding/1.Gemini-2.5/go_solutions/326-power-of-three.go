func isPowerOfThree(n int) bool {
	// A power of three must be a positive integer.
	if n <= 0 {
		return false
	}

	// The largest power of 3 that can be represented by a 32-bit signed integer
	// (max value 2,147,483,647) is 3^19 = 1,162,261,467.
	// If n is a power of three, then 1,162,261,467 must be perfectly divisible by n.
	return 1162261467%n == 0
}