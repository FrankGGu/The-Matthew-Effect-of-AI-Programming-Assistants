func addSpaces(s string, spaces []int) string {
	var builder strings.Builder
	// Pre-allocate capacity for efficiency: original string length + number of spaces
	builder.Grow(len(s) + len(spaces))

	lastIdx := 0
	for