func findLosers(n int, k int) []int {
	seen := make([]bool, n)

	current := 0 // Friend 0 starts with the ball
	seen[current] = true // Mark friend 0 as having received the ball

	round := 1 // 1-indexed round number

	for {
		steps := round * k
		next := (current + steps) % n

		if seen[next] {
			// This friend has already received the ball, game ends
			break
		}

		seen[next] = true // Mark the next friend as having received the ball
		current = next    // Update current player
		round++           // Increment round
	}

	// Collect the losers
	var losers []int
	for i := 0; i < n; i++ {
		if !seen[i] {
			losers = append(losers, i)
		}
	}

	return losers
}