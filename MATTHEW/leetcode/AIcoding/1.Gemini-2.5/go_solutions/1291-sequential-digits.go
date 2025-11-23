func sequentialDigits(low int, high int) []int {
	var result []int

	// Iterate through all possible starting digits (1 to 9)
	for i := 1; i <= 9; i++ {
		num := i
		// Build sequential numbers starting with '