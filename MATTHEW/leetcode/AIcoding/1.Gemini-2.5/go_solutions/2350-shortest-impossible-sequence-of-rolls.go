package main

func shortestImpossibleSequence(rolls []int, k int) int {
	// ans will store the length of the shortest impossible sequence.
	// We start by assuming we can form sequences of length 0 (empty sequence),
	// and are looking to form sequences of length 1.
	// If we successfully form all sequences of length L, ans will become L+1.
	ans := 1

	// seen is a hash map to keep track of the distinct roll values (from 1 to k)
	// that we have encountered since the last time we successfully completed
	// a full set of all k distinct values.
	// This helps us determine if we can "advance" to forming longer sequences.
	seen := make(map[int]bool)

	// countDistinctRolls tracks how many unique roll values (from 1 to k)
	// we have seen in the current "segment" of rolls, after the last reset.
	countDistinctRolls := 0

	for _, r := range rolls {
		// We only care about rolls that are within the valid range [1, k].
		// If a roll is outside this range, it cannot be part of any sequence we are trying to form.
		if r >= 1 && r <= k {
			// If we haven't seen this specific roll value in the current segment,
			// mark it as seen and increment the count of distinct rolls.
			if !seen[r] {
				seen[r] = true
				countDistinctRolls++
			}
		}

		// If we have now seen all k distinct roll values (1 through k)
		// in the current segment of the 'rolls' array:
		// This signifies that we have gathered enough "building blocks" to form
		// all sequences of length 'ans' (the current value of 'ans').
		// For example, if 'ans' was 1, and we collected all 1..k, it means we can form
		// (1), (2), ..., (k).
		// We can now "advance" to trying to form sequences of length 'ans + 1'.
		if countDistinctRolls == k {
			ans++ // Increment the target length for the shortest impossible sequence.

			// Reset the 'seen' map and 'countDistinctRolls' for the next level.
			// We need to find all k distinct rolls again, but this time they will
			// serve as the last element of sequences of the new 'ans' length.
			seen = make(map[int]bool)
			countDistinctRolls = 0
		}
	}

	// After iterating through all rolls, the final value of 'ans' represents
	// the length of the shortest impossible sequence.
	// If 'ans' is M, it means we were able to successfully complete M-1 full sets
	// of 1..k distinct rolls. This implies we can form all sequences up to length M-1.
	// However, we failed to complete the M-th full set of 1..k distinct rolls,
	// meaning there is at least one sequence of length M that cannot be formed.
	return ans
}