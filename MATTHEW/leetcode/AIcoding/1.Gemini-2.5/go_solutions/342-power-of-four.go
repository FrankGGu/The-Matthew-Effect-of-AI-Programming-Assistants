func isPowerOfFour(n int) bool {
	// 1. n must be positive
	// 2. n must be a power of two (only one bit set). This is checked by (n & (n - 1)) == 0.
	//    For example:
	//    4 (0100) &