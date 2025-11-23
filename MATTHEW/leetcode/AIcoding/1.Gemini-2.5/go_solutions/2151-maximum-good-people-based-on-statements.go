func maximumGood(statements [][]int) int {
	n := len(statements)
	maxGoodPeople := 0

	// Iterate through all possible assignments using a bitmask.
	// Each bit in 'mask' represents a person.
	// If the i-th bit is 1, person i is assumed to be good