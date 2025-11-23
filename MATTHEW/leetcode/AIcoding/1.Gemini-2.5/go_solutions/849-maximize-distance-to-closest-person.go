import "math"

func maxDistanceToClosestPerson(seats []int) int {
	n := len(seats)
	maxDist := 0

	// Case 1: Empty seats at the beginning
	firstPersonIdx := -1
	for i := 0; i < n; i++ {
		if seats[i]