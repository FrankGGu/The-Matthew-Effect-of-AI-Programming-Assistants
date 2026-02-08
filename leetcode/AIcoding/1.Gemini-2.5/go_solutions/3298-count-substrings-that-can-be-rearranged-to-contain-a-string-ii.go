package main

func countSubstrings(s string) int64 {
	n := len(s)
	var ans int64 = 0

	lastA := -1
	lastB := -1
	lastC := -1

	for j := 0; j < n; j++ {
		char := s[j]
		if char == 'a' {
			lastA = j
		} else if char == 'b' {
			lastB = j
		} else if char == 'c' {
			lastC = j
		}

		// If all three characters 'a', 'b', and 'c' have appeared at least once
		// up to index j.
		if lastA != -1 && lastB != -1 && lastC != -1 {
			// The starting index 'i' for a valid substring s[i...j] must be
			// less than or equal to the latest occurrence of 'a', 'b', and 'c'.
			// That is, i <= lastA, i <= lastB, and i <= lastC.
			// So, i must be less than or equal to min(lastA, lastB, lastC).
			// The number of such valid 'i' values (from 0 up to min_idx) is min_idx + 1.

			minIdx := lastA
			if lastB < minIdx {
				minIdx = lastB
			}
			if lastC < minIdx {
				minIdx = lastC
			}

			ans += int64(minIdx) + 1
		}
	}

	return ans
}