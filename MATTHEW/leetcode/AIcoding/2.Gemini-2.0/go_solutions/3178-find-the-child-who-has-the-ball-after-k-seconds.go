func findTheWinner(n int, k int) int {
	items := make([]int, n)
	for i := 0; i < n; i++ {
		items[i] = i + 1
	}

	current := 0
	for len(items) > 1 {
		current = (current + k - 1) % len(items)
		items = append(items[:current], items[current+1:]...)
	}

	return items[0]
}