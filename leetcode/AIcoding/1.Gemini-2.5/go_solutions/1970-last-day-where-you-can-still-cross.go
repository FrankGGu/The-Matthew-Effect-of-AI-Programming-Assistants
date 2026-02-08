type Pos struct {
	r, c int
}

func latestDayToCross(row int, col int, cells [][]int) int {
	ans := 0
	left, right := 1, len(cells) // Binary search range for the day

	for left <= right {
		mid := left +