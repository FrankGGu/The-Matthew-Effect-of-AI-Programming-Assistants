package main

func checkRecord(n int) int {
	const MOD = 1_000_000_007

	// dp_prev[absent_count][late_streak] stores counts for length i-1
	// dp_curr[absent_count][late_streak] stores counts for length i
	//
	// absent_count: 0 (no 'A's), 1 (one 'A')
	// late_streak: 0 (ends with P or A), 1 (ends with L), 2 (ends with LL)

	dp_prev := make([][]int, 2)
	for j := range dp_prev {
		dp_prev[j] = make([]int, 3)
	}

	// Base case: empty string (length 0)
	// 0 absences, 0 consecutive lates
	dp_prev[0][0] = 1

	for i := 1; i <= n; i++ {
		dp_curr := make([][]int, 2)
		for j := range dp_curr {
			dp_curr[j] = make([]int, 3)
		}

		// Calculate states for length i based on dp_prev (length i-1)

		// 0 Absences
		// dp_curr[0][0]: ends with 'P'
		// Can come from any state of length i-1 with 0 absences (ending with P, L, or LL) by adding 'P'
		dp_curr[0][0] = (dp_prev[0][0] + dp_prev[0][1] + dp_prev[0][2]) % MOD

		// dp_curr[0][1]: ends with 'L' (1 consecutive L)
		// Must come from state of length i-1 with 0 absences, ending with P or A (late_streak 0) by adding 'L'
		dp_curr[0][1] = dp_prev[0][0] % MOD

		// dp_curr[0][2]: ends with 'LL' (2 consecutive L)
		// Must come from state of length i-1 with 0 absences, ending with L (late_streak 1) by adding 'L'
		dp_curr[0][2] = dp_prev[0][1] % MOD

		// 1 Absence
		// dp_curr[1][0]: ends with 'P'
		// This state can be reached in two ways:
		// 1. Adding 'P' to a record of length i-1 that already has 1 absence.
		// 2. Adding 'A' to a record of length i-1 that has 0 absences.
		dp_curr[1][0] = (dp_prev[1][0] + dp_prev[1][1] + dp_prev[1][2]) % MOD // Adding 'P'
		dp_curr[1][0] = (dp_curr[1][0] + dp_prev[0][0] + dp_prev[0][1] + dp_prev[0][2]) % MOD // Adding 'A'

		// dp_curr[1][1]: ends with 'L' (1 consecutive L)
		// Must come from state of length i-1 with 1 absence, ending with P or A (late_streak 0) by adding 'L'
		dp_curr[1][1] = dp_prev[1][0] % MOD

		// dp_curr[1][2]: ends with 'LL' (2 consecutive L)
		// Must come from state of length i-1 with 1 absence, ending with L (late_streak 1) by adding 'L'
		dp_curr[1][2] = dp_prev[1][1] % MOD

		// Update dp_prev for the next iteration (current becomes previous)
		dp_prev = dp_curr
	}

	// The total number of valid records of length n is the sum of all states for length n.
	total := 0
	for a := 0; a < 2; a++ {
		for l := 0; l < 3; l++ {
			total = (total + dp_prev[a][l]) % MOD
		}
	}

	return total
}