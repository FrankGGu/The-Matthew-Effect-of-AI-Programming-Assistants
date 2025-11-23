func platesBetweenCandles(s string, queries [][]int) []int {
	n := len(s)

	// Precompute prefix sums of plates
	// prefixPlates[i] stores the count of '*' in s[0...i-1]
	prefixPlates := make([]int, n+1)
	for i :=