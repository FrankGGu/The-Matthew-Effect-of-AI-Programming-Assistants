func maximumBinaryString(binary string) string {
	n := len(binary)
	firstZeroIdx := -1
	numZeros := 0

	for i := 0; i < n; i++ {
		if binary[i] == '0' {
			if firstZeroIdx == -1 {
				first