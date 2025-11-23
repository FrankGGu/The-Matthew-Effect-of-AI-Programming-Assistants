func prisonAfterNDays(cells []int, n int) []int {
	// A map to store the state (as an integer) to the day it was first encountered.
	// This helps detect cycles.
	seenStates := make(map[int]int)

	// A slice to store the history of states.