func countFactors(n int, factor int) int {
	count := 0
	if n == 0 { // Problem constraints: grid values are between 1 and 1000. So n will never be 0.
		return 0
	}
	for n > 0 && n%factor == 0 {