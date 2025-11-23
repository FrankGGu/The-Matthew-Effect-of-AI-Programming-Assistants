package main

func numOfWays(n int) int {
	const MOD = 1_000_000_007

	// dp_two_colors represents the number of ways to paint a row with an "ABA" pattern (e.g., 121).
	// dp_three_colors represents the number of ways to paint a row with an "ABC" pattern (e.g., 123).

	// Base case for n = 1
	// For a single row, there are 6 patterns of type ABA (e.g., 121, 131, 212, 232, 313, 323)
	// and 6 patterns of type ABC (e.g., 123, 132, 213, 231, 312, 321).
	twoColorsPrev := 6
	threeColorsPrev := 6

	for i := 2; i <= n; i++ {
		// Calculate current row's counts based on previous row's counts
		// Transitions:
		// If previous row was a two-color pattern (e.g., 121):
		//   - Current row can be a two-color pattern in 5 ways.
		//   - Current row can be a three-color pattern in 4 ways.
		// If previous row was a three-color pattern (e.g., 123):
		//   - Current row can be a two-color pattern in 4 ways.
		//   - Current row can be a three-color pattern in 4 ways.

		// New count for two-color patterns
		twoColorsCurr := (5*twoColorsPrev + 4*threeColorsPrev) % MOD

		// New count for three-color patterns
		threeColorsCurr := (4*twoColorsPrev + 4*threeColorsPrev) % MOD

		twoColorsPrev = twoColorsCurr
		threeColorsPrev = threeColorsCurr
	}

	return (twoColorsPrev + threeColorsPrev) % MOD
}