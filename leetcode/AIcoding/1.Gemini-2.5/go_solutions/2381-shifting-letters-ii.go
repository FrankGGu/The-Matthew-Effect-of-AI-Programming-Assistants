func shiftingLetters(s string, shifts [][]int) string {
	n := len(s)
	diff := make([]int, n+1)

	for _, shift := range shifts {
		start := shift[0]
		end := shift[1]
		direction := shift[2]

		if direction ==