func miceAndCheese(reward1 []int, reward2 []int, k int) int {
	n := len(reward1)

	// Initialize total score by assuming mouse 2 eats all cheeses.
	// We will then adjust this score by letting mouse 1 eat k cheeses