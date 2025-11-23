func getNextSequence(s string) string {
	var builder strings.Builder
	n := len(s)
	if n == 0 {
		return ""
	}

	i := 0
	for i < n {
		j := i