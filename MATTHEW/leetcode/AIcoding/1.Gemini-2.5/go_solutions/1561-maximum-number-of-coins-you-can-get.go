func maxCoins(piles []int) int {
	sort.Ints(piles)

	n := len(piles) / 3
	myCoins := 0

	// We iterate n times.
	// In each iteration, we consider the current largest pile (for Alice),