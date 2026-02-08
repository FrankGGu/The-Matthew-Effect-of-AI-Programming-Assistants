func getEncryptedString(s string, k int) string {
	n := len(s)
	if n == 0 {
		return ""
	}

	effectiveK := k % n

	result := make([]byte, n)

	for i := 0; i < n; i++ {
		originalIndex :=