func findMaximumNumberofNonIntersectingSubstrings(s string) []string {
	n := len(s)
	left := make([]int, 26)
	right := make([]int, 26)

	// Initialize left array with -1 to indicate not found
	for i := 0; i < 26; i++ {
		left[i] = -1
	}

	// Populate left and right occurrence arrays
	for i := 0; i < n; i++ {
		charIdx := s[i] - 'a'
		if left[charIdx] == -1 {
			left[charIdx] = i
		}
		right[charIdx] = i
	}

	var candidates [][]int // Stores [start, end] of valid substrings

	i := 0
	for i < n {
		charIdx := s[i] - 'a'

		// If the current character s[i] is not its first occurrence,
		// then 'i' cannot be the start of a valid substring that includes s[i].
		// Any such substring must start at or before left[s[i]].
		// So we skip this 'i' and try the next one.
		if left[charIdx] < i {
			i++
			continue
		}

		// 'i' is a potential start of a valid substring.
		// We need to find the smallest end 'currentEnd' such that s[i:currentEnd+1]
		// is a valid substring according to the problem's condition.
		currentStart := i
		currentEnd := right[charIdx]
		isCandidateValid := true

		k := i
		for k <= currentEnd {
			charKIdx := s[k] - 'a'

			// If any character s[k] within the segment [currentStart, currentEnd]
			// has its first occurrence before currentStart, then this segment
			// cannot be a valid substring starting at currentStart.
			// This means 'i' (which is currentStart) is not a valid starting point.
			if left[charKIdx] < currentStart {
				isCandidateValid = false
				// If this happens, we must skip all starting points up to 'k',
				// because s[k] forces any containing substring to start at left[s[k]] or earlier.
				// So, 'i' cannot be a valid start. The next potential valid start is k+1.
				// The outer loop will increment 'i', so we set 'i' to 'k'.
				i = k
				break
			}

			// Extend currentEnd if s[k]'s last occurrence is further
			currentEnd = max(currentEnd, right[charKIdx])
			k++
		}

		if isCandidateValid {
			// We found a valid substring s[currentStart:currentEnd+1].
			// To maximize the number of non-intersecting substrings, we greedily pick this one
			// and then search for the next substring starting after its end.
			candidates = append(candidates, []int{currentStart, currentEnd})
			// The outer loop will increment 'i', so we set 'i' to 'currentEnd'.
			i = currentEnd
		} else {
			// If not valid, 'i' was already updated to 'k' to skip invalid starting points.
			// The outer loop will increment 'i' to 'k+1'.
		}
		i++ // Move to the next potential starting point
	}

	var result []string
	for _, p := range candidates {
		result = append(result, s[p[0]:p[1]+1])
	}

	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}