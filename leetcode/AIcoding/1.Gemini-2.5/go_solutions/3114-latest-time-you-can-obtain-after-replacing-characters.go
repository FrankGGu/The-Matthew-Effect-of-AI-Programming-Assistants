func findLatestTime(s string) string {
	res := []rune(s)

	// Handle hours
	// Determine the first digit of the hour (res[0])
	if res[0] == '?' {
		// If res[1] is '?', '0', or '1', then res[0