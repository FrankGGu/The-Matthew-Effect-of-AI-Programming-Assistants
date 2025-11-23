func removeKdigits(num string, k int) string {
	stack := make([]byte, 0, len(num)) // Use a byte slice as a stack

	for i := 0; i < len(num); i++ {
		digit := num[i]

		// While stack is not empty, k removals are available