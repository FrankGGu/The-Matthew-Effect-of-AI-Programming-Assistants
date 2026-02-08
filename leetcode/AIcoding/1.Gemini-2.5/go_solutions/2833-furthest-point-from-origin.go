func furthestDistanceFromOrigin(moves string) int {
	leftCount := 0
	rightCount := 0
	underscoreCount := 0

	for _, move := range moves {
		if move == 'L' {
			leftCount++
		} else if move == 'R' {
			rightCount++
		} else { // move == '_'
			underscoreCount++
		}
	}

	// Calculate the net displacement from 'L' and 'R' moves.
	// A positive value means a tendency to the right, negative to the left.
	baseDisplacement := rightCount - leftCount

	// To maximize the absolute distance from the origin,
	// all '_' moves should be chosen to extend the current