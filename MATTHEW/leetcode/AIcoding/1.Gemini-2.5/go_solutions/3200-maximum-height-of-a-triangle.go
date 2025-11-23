func solve(redBalls, blueBalls int, startWithRed bool) int {
	height := 0
	currentRed := redBalls
	currentBlue := blueBalls
	isRedRow := startWithRed // true if current row should be red, false if blue

	for {
		height++ // Attempt to build the current row