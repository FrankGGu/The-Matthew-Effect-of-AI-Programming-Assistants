func canSeePersonsCount(heights []int) []int {
	n := len(heights)
	ans := make([]int, n)
	stack := []int{} // Monotonic decreasing stack storing indices

	// Iterate from right to left
	for i := n - 1; i >= 0; i--