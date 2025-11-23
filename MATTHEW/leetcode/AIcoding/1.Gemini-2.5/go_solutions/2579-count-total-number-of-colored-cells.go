func coloredCells(n int) int64 {
	n64 := int64(n)
	return 2*n64*n64 - 2*n64 + 1
}