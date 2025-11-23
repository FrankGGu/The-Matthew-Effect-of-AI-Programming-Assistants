func numWays(steps int, arrLen int) int {
	const MOD = 1e9 + 7

	// The maximum position we need to consider is min(steps, arrLen - 1).
	// However, to return to index 0, we can't go further than steps/2 steps away.
	// So,