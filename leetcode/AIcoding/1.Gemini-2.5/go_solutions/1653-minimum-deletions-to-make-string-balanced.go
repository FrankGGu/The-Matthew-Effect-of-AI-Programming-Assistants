import "strings"

func minimumDeletions(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	// Calculate total 'a's in the string.
	// This will be the initial number of deletions if we want to make the entire string 'b's.
	totalAs := strings.Count(s, "a")

	// Initialize minDeletions.
	// This represents the case where the string is made entirely of 'b's (conceptual split point before index 0).
	// All 'a's must be deleted.
	minDeletions := totalAs

	bCountLeft := 0      // Count of 'b's encountered so far (to the left of current split point)
	aCountRight := totalAs // Count of 'a's remaining to the right of current split point

	// Iterate through all possible split points.
	// A split point `i` means we consider s[0...i] to be the 'a' part
	// and s[i+1...n-1] to be the 'b' part.
	//
	// For each character s[i]:
	// If s[i] is 'a', it means this 'a' is now part of the left section (the 'a's part).
	// So, it's no longer an 'a' that needs to be deleted from the right section.
	// If s[i] is 'b', it means this 'b' is now part of the left section (the 'a's part).
	// So, it's a 'b' that needs to be deleted from the left section.
	for i := 0; i < n; i++ {
		if s[i] == 'a' {
			aCountRight-- // This 'a' is now to the left of the split point, so it's not an 'a' that needs to be deleted from the right part.
		} else { // s[i] == 'b'
			bCountLeft++ // This 'b' is to the left of the split point, so it's a 'b' that needs to be deleted from the left part.
		}

		// Calculate current deletions for this split point:
		// bCountLeft: 'b's that are in the 'a'-part (left part) and must be deleted.
		// aCountRight: 'a's that are in the 'b'-part (right part) and must be deleted.
		currentDeletions := bCountLeft + aCountRight
		if currentDeletions < minDeletions {
			minDeletions = currentDeletions
		}
	}

	return minDeletions
}