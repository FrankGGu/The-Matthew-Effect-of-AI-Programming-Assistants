func findKthBit(n int, k int) byte {
	if n == 1 {
		return '0'
	}

	// Calculate the length of Sn. Length of Sn is 2^n - 1.
	// We can use bit shift for 2^n: 1 << n
	// So, length = (1 << n) - 1.
	// The middle index is 2^(n-1).
	// mid = 1 << (n - 1)

	mid := 1 << (n - 1) // This is 2^(n-1)

	if k == mid {
		// If k is the middle index, the character is '1' (from the rule S_i = S_{i-1} + "1" + reverse(invert(S_{i-1})))
		return '1'
	} else if k < mid {
		// If k is in the first half, it's the same as the k-th character of S_{n-1}
		return findKthBit(n-1, k)
	} else { // k > mid
		// If k is in the second half (the reversed and inverted part)
		// The corresponding index in the original S_{n-1} (before reverse and invert) needs to be calculated.
		// Let L_{n-1} be the length of S_{n-1}. L_{n-1} = (1 << (n-1)) - 1.
		// The index in the reversed part (1-indexed from the start of the reversed part) is `k - mid`.
		// To find its original position in S_{n-1}, we use symmetry: L_{n-1} - (k - mid) + 1.
		// Let's simplify this:
		// L_{n-1} - k + mid + 1
		// = ((1 << (n-1)) - 1) - k + (1 << (n-1)) + 1
		// = (1 << (n-1)) + (1 << (n-1)) - k
		// = (2 * (1 << (n-1))) - k
		// = (1 << n) - k

		// So, the character at this effective index in S_{n-1} is found.
		// Then, we invert that character because it came from `invert(S_{n-1})`.

		charFromPrevString := findKthBit(n-1, (1<<n) - k)
		if charFromPrevString == '0' {
			return '1'
		}
		return '0'
	}
}