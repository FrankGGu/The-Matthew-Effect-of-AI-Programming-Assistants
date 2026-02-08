func dieSimulator(n int, rollMax []int) int {
	const MOD int = 1e9 + 7

	// dp[i][j][k] represents the number of sequences of length i
	// where the last die rolled is j, and it has been rolled k times consecutively.
	// i: number of