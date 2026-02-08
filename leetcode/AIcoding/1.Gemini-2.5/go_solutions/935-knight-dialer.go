func knightDialer(n int) int {
	if n == 1 {
		return 10
	}

	const MOD = 1e9 + 7

	// Adjacency list for knight moves on a phone pad
	// Index i represents digit i, and the slice contains digits it can jump to.
	var moves