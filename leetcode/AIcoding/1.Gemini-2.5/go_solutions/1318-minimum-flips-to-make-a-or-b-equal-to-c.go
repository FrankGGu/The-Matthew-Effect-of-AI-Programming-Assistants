func minFlips(a int, b int, c int) int {
	flips := 0

	for a > 0 || b > 0 || c > 0 {
		bitA := a & 1
		bitB := b & 1
		bitC := c & 1

		if bitC == 0 {