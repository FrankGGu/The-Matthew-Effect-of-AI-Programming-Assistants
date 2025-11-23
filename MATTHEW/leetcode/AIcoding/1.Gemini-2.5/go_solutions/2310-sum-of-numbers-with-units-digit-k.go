func minimumNumbers(num int, k int) int {
	if num == 0 {
		return 0
	}

	// Iterate through possible counts of numbers.
	// The units digit of the sum (c * k) repeats every 10 counts.
	// So, we only need to check c from 1 to 10