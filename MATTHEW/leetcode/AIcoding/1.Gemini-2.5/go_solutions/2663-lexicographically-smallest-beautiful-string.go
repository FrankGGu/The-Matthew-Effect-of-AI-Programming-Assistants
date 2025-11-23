func getSmallestString(s string, k int) string {
	n := len(s)
	arr := []byte(s)

	for i := n - 1; i >= 0; i-- {
		// Try to increment arr[i]
		for charCode := arr[i] + 1; char