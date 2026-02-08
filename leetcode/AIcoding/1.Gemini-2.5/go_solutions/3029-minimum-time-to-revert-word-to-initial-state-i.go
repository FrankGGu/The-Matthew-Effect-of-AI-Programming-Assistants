func minimumTimeToInitialState(word string, k int) int {
	n := len(word)
	originalWord := word

	for ops := 1; ; ops++ {
		// Simulate one operation: remove first k characters and append them to the end.
		// This is equivalent to a cyclic shift by k positions.
		//