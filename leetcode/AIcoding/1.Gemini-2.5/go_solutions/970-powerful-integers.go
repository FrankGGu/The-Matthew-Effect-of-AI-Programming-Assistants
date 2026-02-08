func powerfulIntegers(x int, y int, bound int) []int {
	powerfulInts := make(map[int]bool)

	currentX := 1
	for i := 0; ; i++ {
		// If currentX alone exceeds bound, any sum involving it