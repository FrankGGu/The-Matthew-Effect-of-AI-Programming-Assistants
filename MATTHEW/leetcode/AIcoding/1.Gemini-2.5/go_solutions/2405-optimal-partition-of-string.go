func partitionString(s string) int {
	if len(s) == 0 {
		return 0
	}

	count := 1
	seenChars := [26]bool{} // Using a boolean array for O(1) character lookup and reset

	for _, char := range s {
		idx := char