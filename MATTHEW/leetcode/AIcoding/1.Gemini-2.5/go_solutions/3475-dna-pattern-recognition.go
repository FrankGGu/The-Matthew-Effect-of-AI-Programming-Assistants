func findRepeatedDnaSequences(s string) []string {
	if len(s) < 10 {
		return []string{}
	}

	// Use a map to store the frequency of each 10-letter sequence.
	// The key is the sequence string, and the value is its count.
	counts := make(map[string]int)

	// Use a slice to store the result.
	var result []string

	// Iterate through the string to extract all 10-letter sequences.
	// The loop runs from index 0 up to len(s) - 10.
	for i := 0; i <= len(s)-10; i++ {
		// Extract the current 10-letter sequence.
		sub := s[i : i+10]

		// Increment its count in the map.
		counts[sub]++

		// If the count for this sequence becomes 2, it means we have found a
		// repeated sequence for the first time (i.e., it occurred once before
		// and now again). Add it to the result slice.
		if counts[sub] == 2 {
			result = append(result, sub)
		}
	}

	return result
}