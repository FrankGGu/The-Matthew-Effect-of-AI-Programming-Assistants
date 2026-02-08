func maximumXorProduct(a int64, b int64, n int) int {
	mod := int64(1_000_000_007)

	currentA := uint64(0)
	currentB := uint64(0)

	for i := n - 1; i >= 0; i-- {
		bitA := (a >> i) & 1
		bitB := (b >> i) & 1

		if bitA == bitB {
			// If a_i and b_i are the same, to maximize (a^x) and (b^x),
			// we want both (a^x)_i and (b^x)_i to be 1.
			// This is achieved by setting x_i = 1 - bitA.
			currentA = (currentA << 1) | 1
			currentB = (currentB << 1) | 1
		} else {
			// If a_i and b_i are different, one of (a^x)_i or (b^x)_i must be 0 and the other 1.
			// To maximize the product (a^x) * (b^x), we want (a^x) and (b^x) to be as close as possible.
			// So, we assign the '1' to the number that is currently smaller (or equal) to balance them.
			if currentA <= currentB {
				// Assign 1 to currentA, 0 to currentB for this bit position.
				// This means (a^x)_i = 1 and (b^x)_i = 0.
				currentA = (currentA << 1) | 1
				currentB = (currentB << 1) | 0
			} else { // currentA > currentB
				// Assign 0 to currentA, 1 to currentB for this bit position.
				// This means (a^x)_i = 0 and (b^x)_i = 1.
				currentA = (currentA << 1) | 0
				currentB = (currentB << 1) | 1
			}
		}
	}

	// Calculate the product modulo 10^9 + 7.
	// currentA and currentB can be large (up to 2^60-1), so take modulo before multiplication.
	result := (int64(currentA%mod) * int64(currentB%mod)) % mod
	return int(result)
}