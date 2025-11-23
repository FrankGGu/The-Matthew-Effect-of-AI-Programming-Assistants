func winnerOfGame(colors string) bool {
	aliceMoves := 0
	bobMoves := 0
	n := len(colors)

	if n < 3 {
		return false // Not enough pieces for any move to be made
	}

	for i := 1; i < n-1; i++ {