func oddString(words []string) string {
	// Helper function to calculate the difference array for a given word
	getDiffArray := func(word string) []int {
		diff := make([]int, len(word)-1)
		for i := 0