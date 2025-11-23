func baseNeg2(n int) string {
	if n == 0 {
		return "0"
	}

	var sb strings.Builder
	for n != 0 {
		remainder := n % (-2)
		if remainder < 0 {
			remainder += 2 // Adjust