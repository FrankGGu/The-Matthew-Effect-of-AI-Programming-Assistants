func integerReplacement(n int) int {
	count := 0
	for n != 1 {
		if n%2 == 0 {
			n /= 2
		} else {
			// n is odd
			if n == 3 {
				// Special case: 3 -> 2 -> 1 (2 steps) is better than 3 -> 4 -> 2 -> 1 (3 steps)
				n = 2
			} else if (n+1)%4 == 0 { // n % 4 == 3, e.g., 7, 11, 15. n+1 is divisible by 4.
				n++
			} else { // n % 4 == 1, e.g., 5, 9, 13. n-1 is divisible by 4.
				n--
			}
		}
		count++
	}
	return count
}