func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximizeWin(prizes []int, k int) int {
	n := len(prizes)
	if n == 0 {