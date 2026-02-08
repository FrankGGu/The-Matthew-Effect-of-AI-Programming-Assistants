func decodeAtIndex(s string, k int) string {
	var currentLength int64 = 0

	// First pass: Calculate the total length of the decoded string
	// or stop if currentLength exceeds k and the remaining string is all letters.