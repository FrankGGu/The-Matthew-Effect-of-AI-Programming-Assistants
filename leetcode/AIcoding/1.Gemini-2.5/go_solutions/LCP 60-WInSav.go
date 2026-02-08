func solve(balls string, shotBall byte, shotIdx int) string {
	// Step 1: Insert the shotBall into the existing sequence
	// Convert string to a slice of bytes for easier manipulation
	b := []byte(balls)

	// Create a new slice with enough capacity for the inserted ball
	newBalls := make([]byte