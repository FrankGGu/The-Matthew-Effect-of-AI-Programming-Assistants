func concatenatedBinary(n int) int {
	const mod = 1_000_000_007
	var res int64 = 0
	var bitLength int = 0 // Represents the number of bits for the current number i

	for i := 1; i <= n; i++ {
		// Check if i is a power of 2. If it is, the number of bits required to represent
		// numbers from i onwards increases by 1.
		// For example:
		// 1 (1 bit)
		// 2 (2 bits)
		// 3 (2 bits)
		// 4 (3 bits)
		// This condition `(i & (i - 1)) == 0` is true if i is a power of 2.
		if (i & (i - 1)) == 0 {
			bitLength++
		}

		// Shift the current result by `bitLength` positions to the left,
		// effectively making space for the binary representation of `i`.
		// Then add `i` and take modulo.
		res = ((res << bitLength) % mod + int64(i)) % mod
	}

	return int(res)
}