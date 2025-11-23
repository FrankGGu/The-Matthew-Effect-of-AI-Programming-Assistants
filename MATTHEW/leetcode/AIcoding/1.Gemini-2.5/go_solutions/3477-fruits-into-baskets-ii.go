import "math"

func totalFruit(fruits []int) int {
	basket := make(map[int]int)
	left := 0
	maxLength := 0

	for right := 0; right < len(fruits); right++ {
		// Add the current fruit to the basket
		basket[fruits[