import (
	"sort"
)

func findRadius(houses []int, heaters []int) int {
	sort.Ints(houses)
	sort.Ints(heaters)

	maxRadius := 0
	heaterIdx := 0

	for _, house := range houses {
		// Advance heaterIdx such that heaters[heaterIdx] is the largest heater
		// that is less than or equal to `house`, or `heaterIdx` is 0 if all heaters
		// are greater than `house`.
		// The loop stops when heaters[heaterIdx+1] is >= house, or heaterIdx is at the last heater.
		for heaterIdx < len(heaters)-1 && heaters[heaterIdx+1] < house {
			heaterIdx++
		}

		// Now, heaters[heaterIdx] is a candidate heater (to the left or at `house`).
		// heaters[heaterIdx+1] (if it exists) is the other candidate heater (to the right of `house`).

		dist1 := abs(house - heaters[heaterIdx])
		currentMinDist := dist1

		// If there is a heater to the right of heaters[heaterIdx], consider it as well.
		if heaterIdx < len(heaters)-1 {
			dist2 := abs(house - heaters[heaterIdx+1])
			currentMinDist = min(dist1, dist2)
		}

		maxRadius = max(maxRadius, currentMinDist)
	}

	return maxRadius
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}