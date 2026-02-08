func minimumSwaps(s1 string, s2 string) int {
	countXY := 0 // Number of positions where s1[i] = 'x' and s2[i] = 'y'
	countYX := 0 // Number of positions where s1[i] = 'y' and s2[i] = 'x'

	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			if s1[i] == 'x' {
				countXY++
			} else { // s1[i] == 'y'
				countYX++
			}
		}
	}

	// For s1 and s2 to become equal, the total count of 'x's in s1 must equal
	// the total count of 'x's in s2, and similarly for 'y's.
	// The allowed swaps (within s1 or within s2) preserve the character counts
	// within each string.
	//
	// Let N_x1 be the count of 'x's in s1, N_y1 be 'y's in s1.
	// Let N_x2 be the count of 'x's in s2, N_y2 be 'y's in s2.
	//
	// If s1[k] == s2[k] == 'x', it contributes to N_x1 and N_x2.
	// If s1[k] == s2[k] == 'y', it contributes to N_y1 and N_y2.
	// If s1[k] == 'x' and s2[k] == 'y' (countXY case), it contributes 'x' to N_x1 and 'y' to N_y2.
	// If s1[k] == 'y' and s2[k] == 'x' (countYX case), it contributes 'y' to N_y1 and 'x' to N_x2.
	//
	// For N_x1 == N_x2 to hold, (count of 'x' in matching positions) + countXY must equal
	// (count of 'x' in matching positions) + countYX.
	// This implies countXY == countYX.
	// Similarly, for N_y1 == N_y2 to hold, it implies countYX == countXY.
	//
	// Therefore, if countXY is not equal to countYX, it's impossible to make the strings equal.
	if countXY != countYX {
		return -1
	}

	// If countXY == countYX, let this common count be k.
	// We have k positions where s1[i] = 'x' and s2[i] = 'y'.
	// And k positions where s1[j] = 'y' and s2[j] = 'x'.
	//
	// Consider one 'xy' mismatch (at index i) and one 'yx' mismatch (at index j):
	// s1: ...x...y...
	// s2: ...y...x...
	//
	// Perform a swap of s1[i] with s1[j]:
	// s1 becomes: ...y...x...
	// s2 remains: ...y...x...
	//
	// After this single swap, s1[i] == s2[i] ('y') and s1[j] == s2[j] ('x').
	// This one swap resolves two mismatches.
	//
	// Since we have k pairs of (xy, yx) mismatches, we can perform k such swaps.
	// Each swap resolves one 'xy' and one 'yx' mismatch.
	// Total swaps = k.
	return countXY
}