func coloredCells(n int) int64 {
	if n == 1 {
		return 1
	}
	return int64(2*n*(n-1) + 1)
}