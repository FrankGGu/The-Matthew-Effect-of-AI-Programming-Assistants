func compress(chars []byte) int {
	if len(chars) == 0 {
		return 0
	}

	read := 0  // Pointer to read from the original array
	write := 0 // Pointer to write to the compressed array

	for read < len(chars)