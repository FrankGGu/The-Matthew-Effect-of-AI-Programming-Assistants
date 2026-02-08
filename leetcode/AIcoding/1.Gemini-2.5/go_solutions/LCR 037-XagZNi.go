import "math"

func asteroidCollision(asteroids []int) []int {
	stack := []int{}

	for _, ast := range asteroids {
		currentAstSurvives := true
		for currentAstSurvives && len(stack) > 0 && ast < 0 && stack[len(stack)-1