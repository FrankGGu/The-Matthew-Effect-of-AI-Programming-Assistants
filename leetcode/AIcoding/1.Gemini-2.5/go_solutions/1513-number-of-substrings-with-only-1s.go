func numSub(s string) int {
	const MOD int = 1_000_000_007
	var totalSubstrings int64 = 0
	var currentConsecutiveOnes int64 = 0

	for _, char := range s {
		if char == '1' {
			current