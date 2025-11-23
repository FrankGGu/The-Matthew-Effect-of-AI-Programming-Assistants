func getMaxRepetitions(s1 string, n1 int, s2 string, n2 int) int {
	if n1 == 0 || n2 == 0 || len(s1) == 0 || len(s2) == 0 {
		return 0
	}

	// recall[idx2] stores [s1_consumed_count, s2_completed_count]
	// when we start processing an s1 repetition and the current index in s2 is idx2.
	// This helps detect cycles.
	// The key `idx2` represents the index in s2 where the matching process
	// would resume at the start of the next s1.
	recall := make(map[int][]int)

	s1ConsumedCount := 0   // Total number of s1 repetitions processed
	s2CompletedCount := 0  // Total number of s2 repetitions fully matched
	idx2 := 0              // Current index in s2 we are trying to match

	for s1ConsumedCount < n1 {
		s1ConsumedCount++ // Process one s1 repetition

		// Try to match s2 characters using the current s1
		for i := 0; i < len(s1); i++ {
			if s1[i] == s2[idx2] {
				idx2++
				if idx2 == len(s2) {
					s2CompletedCount++
					idx2 = 0 // Reset idx2 to 0, meaning a full s2 is matched
				}
			}
		}

		// Check for cycle detection
		// If we have seen this 'idx2' before, it means we've returned to a previous state
		// (same starting point in s2 for a new s1 repetition), indicating a cycle.
		if val, ok := recall[idx2]; ok {
			prevS1ConsumedCount := val[0]
			prevS2CompletedCount := val[1]

			// Calculate the length of the cycle in terms of s1 and s2 repetitions
			s1CycleLen := s1ConsumedCount - prevS1ConsumedCount
			s2CycleLen := s2CompletedCount - prevS2CompletedCount

			// Calculate how many full cycles can be skipped
			remainingS1 := n1 - s1ConsumedCount
			numCyclesToSkip := remainingS1 / s1CycleLen

			// Update s2CompletedCount and s1ConsumedCount by skipping these cycles
			s2CompletedCount += numCyclesToSkip * s2CycleLen
			s1ConsumedCount += numCyclesToSkip * s1CycleLen

			// After skipping cycles, the loop will continue for the remaining s1s,
			// which will be fewer than s1CycleLen.
			// The main loop condition `s1ConsumedCount < n1` will correctly handle
			// the termination.
		} else {
			// If this 'idx2' is seen for the first time, store the current state
			recall[idx2] = []int{s1ConsumedCount, s2CompletedCount}
		}
	}

	return s2CompletedCount / n2
}