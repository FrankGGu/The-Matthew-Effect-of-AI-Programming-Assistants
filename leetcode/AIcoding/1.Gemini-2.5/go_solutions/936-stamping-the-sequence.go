package main

import "slices" // For Go 1.21+ slices.Reverse

func movesToStamp(stamp string, target string) []int {
	m := len(stamp)
	n := len(target)

	stampBytes := []byte(stamp)
	targetBytes := []byte(target) // Original target, not modified

	// windows[i] stores the state of the window starting at index i in target.
	// matched: count of characters in targetBytes[i...i+m-1] that match stampBytes
	//          AND are not yet conceptually stamped ('?')
	// mismatched: count of characters in targetBytes[i...i+m-1] that do NOT match stampBytes
	//             AND are not yet conceptually stamped ('?')
	windows := make([]struct {
		matched    int
		mismatched int
	}, n-m+1)

	// affectedByChar[k] stores a list of window starting indices 'i'
	// where targetBytes[k] is part of the window targetBytes[i...i+m-1].
	affectedByChar := make([][]int, n)

	// isCharStamped[k] is true if targetBytes[k] has been conceptually turned into '?'.
	isCharStamped := make([]bool, n)
	stampedCount := 0 // Total number of '?' characters in the conceptual target.

	// processedWindow[i] is true if window 'i' has been added to the queue 'q'
	// (and will eventually be added to 'ans'). This prevents duplicate processing.
	processedWindow := make([]bool, n-m+1)

	q := []int{} // Queue of window starting indices 'i' that are ready to be "un-stamped".

	// Pre-processing: Initialize window states and populate affectedByChar.
	for i := 0; i <= n-m; i++ {
		for j := 0; j < m; j++ {
			charIdx := i + j
			if targetBytes[charIdx] == stampBytes[j] {
				windows[i].matched++
			} else {
				windows[i].mismatched++
			}
		}

		// If a window has no mismatches initially, it means it's a perfect match (possibly with '?'s).
		// It's ready to be un-stamped.
		if windows[i].mismatched == 0 {
			q = append(q, i)
			processedWindow[i] = true
		}

		// Populate affectedByChar for this window 'i'.
		for j := 0; j < m; j++ {
			affectedByChar[i+j] = append(affectedByChar[i+j], i)
		}
	}

	ans := []int{} // Stores the sequence of stamp indices.

	// Main loop (BFS-like): Process the queue.
	for len(q) > 0 {
		i := q[0]
		q = q[1:] // Dequeue

		ans = append(ans, i) // Record the stamp application.

		// "Un-stamp" this window: Mark its characters as '?' conceptually.
		for j := 0; j < m; j++ {
			charIdx := i + j
			if !isCharStamped[charIdx] {
				isCharStamped[charIdx] = true
				stampedCount++

				// For all windows that cover 'charIdx':
				// Update their 'matched' or 'mismatched' counts,
				// and add them to the queue if they become eligible.
				for _, affectedWindowIdx := range affectedByChar[charIdx] {
					// 'charIdx' has just become '?'.
					// We need to determine if 'targetBytes[charIdx]' (original value)
					// was a match or a mismatch for 'stampBytes[charIdx - affectedWindowIdx]'.
					if targetBytes[charIdx] == stampBytes[charIdx-affectedWindowIdx] {
						windows[affectedWindowIdx].matched--
					} else {
						windows[affectedWindowIdx].mismatched--
					}

					// If this affected window now has no mismatches, and hasn't been processed yet:
					// It means all its non-'?' characters now match the stamp (or are already '?').
					// So, it's ready to be un-stamped.
					if windows[affectedWindowIdx].mismatched == 0 && !processedWindow[affectedWindowIdx] {
						q = append(q, affectedWindowIdx)
						processedWindow[affectedWindowIdx] = true
					}
				}
			}
		}
	}

	// If not all characters in the target were stamped, no solution exists.
	if stampedCount != n {
		return []int{}
	}

	// The 'ans' slice contains indices in reverse order of application.
	// Reverse it to get the correct order.
	slices.Reverse(ans)
	return ans
}