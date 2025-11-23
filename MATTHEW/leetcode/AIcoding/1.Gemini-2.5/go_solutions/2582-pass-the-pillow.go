package main

func passThePillow(n int, time int) int {
	cycleLength := 2 * (n - 1)
	remainder := time % cycleLength

	if remainder < n-1 {
		// The pillow is moving from person 1 towards person n
		return 1 + remainder
	} else {
		// The pillow is moving from person n towards person 1
		// Calculate how many steps back from person n it has moved
		stepsBack := remainder - (n - 1)
		return n - stepsBack
	}
}