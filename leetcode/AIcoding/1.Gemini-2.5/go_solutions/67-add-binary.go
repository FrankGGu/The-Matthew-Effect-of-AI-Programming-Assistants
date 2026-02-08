func addBinary(a string, b string) string {
	i := len(a) - 1
	j := len(b) - 1
	carry := 0

	var resultBuilder strings.Builder

	for i >= 0 || j >= 0 || carry >