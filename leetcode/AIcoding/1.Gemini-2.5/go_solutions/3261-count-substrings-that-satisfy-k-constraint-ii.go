func countSubstrings(s string, k int) int64 {
	n := len(s)
	var totalCount int64 = 0

	// This outer loop iterates through all possible minimum frequencies for any character.
	// For each minimum frequency 'minFreq', we find all substrings where all characters
	// have