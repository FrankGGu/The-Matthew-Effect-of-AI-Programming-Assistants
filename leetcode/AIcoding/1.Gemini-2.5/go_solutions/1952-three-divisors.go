func isThree(n int) bool {
	// Numbers less than 4 cannot have exactly three divisors.
	// 1 has 1 divisor.
	// 2 has 2 divisors.
	// 3 has 2 divisors.
	if n < 4 {
		return