func maxCount(m int, n int, ops [][]int) int {
	minRow := m
	minCol := n

	for _, op := range ops {
		if op[0] < minRow {
			minRow = op[0]
		}
		if op[1] < minCol {