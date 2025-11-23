package main

func countDigitOne(n int) int {
	if n <= 0 {
		return 0
	}

	count := 0
	var k int64 = 1 // k represents the current digit's place value (1, 10, 100, ...)

	for k <= int64(n) {
		var divider int64 = k * 10

		// Calculate the number of full blocks of 10*k
		// (int64(n) / divider) gives how many times 'divider' fits into 'n'.
		// Each such block contributes 'k' ones at the current digit place.
		count += int((int64(n) / divider) * k)

		// Calculate the contribution from the partial block (the remainder)
		// (int64(n) % divider) gives the remainder after full blocks.
		var remainder int64 = int64(n) % divider

		// 'val' represents the count of '1's if the current digit is 1
		// within the partial block. It ranges from 'k' up to 'remainder'.
		// So, it's (remainder - k + 1).
		val := remainder - k + 1

		var partialCount int64
		// Equivalent to max(val, 0)
		if val < 0 {
			partialCount = 0
		} else {
			partialCount = val
		}

		// Equivalent to min(partialCount, k)
		// The number of '1's in a block of size 'k' cannot exceed 'k'.
		if partialCount > k {
			partialCount = k
		}

		count += int(partialCount)

		// Move to the next digit place (tens, hundreds, thousands, ...)
		k *= 10
	}

	return count
}