func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func tallestBillboard(rods []int) int {
	totalSum := 0
	for _, rod := range rods {
		totalSum += rod