func manhattanDistances(n int, positions [][]int, pieces [][]int) int {
	xPositions := make([]int, n)
	yPositions := make([]int, n)
	xPieces := make([]int, n)
	yPieces := make([]int, n)