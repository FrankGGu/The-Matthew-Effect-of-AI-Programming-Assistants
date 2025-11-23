func decode(encoded []int) []int {
	n := len(encoded) + 1

	totalXORPerm := 0
	for i := 1; i <= n; i++ {
		totalXORPerm ^= i
	}

	xorOfEncodedOddIndices := 0
	for i := 1; i < n-1; i += 2 {
		xorOfEncodedOddIndices ^= encoded[i]
	}

	perm := make([]int, n)
	perm[0] = totalXORPerm ^ xorOfEncodedOddIndices

	for i := 0; i < n-1; i++ {
		perm[i+1] = perm[i] ^ encoded[i]
	}

	return perm
}