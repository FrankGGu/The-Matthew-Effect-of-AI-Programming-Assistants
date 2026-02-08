import (
	"math"
)

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

func maximumPointsInsideSquare(points [][]int) int {
	// minLForVal stores for each unique value of `min(abs(x), abs(y))` (the key),
	// the minimum `max(abs(x), abs(y))` (the value) required to include a point with that `min(abs(x), abs(y))` value.
	// This `max(abs(x), abs(y))` effectively represents `L` for a square of side `2L` centered at the origin.
	minLForVal := make(map[int]int)

	for _, p := range points {
		x, y := p[0], p[1]
		absX, absY := abs(x), abs(y)

		// Calculate `val = min(abs(x), abs(y))`
		val := min(absX, absY)
		// Calculate `reqL = max(abs(x), abs(y))`
		// This `reqL` is the minimum `L` such that a square of side `2L` centered at origin
		// would contain the point `(x, y)`.
		reqL := max(absX, absY)

		// Update minLForVal: for each `val`, we want to find the smallest `reqL`.
		if currentMinL, exists := minLForVal[val]; !exists || reqL < currentMinL {
			minLForVal[val] = reqL
		}
	}

	// The problem states that a square cannot contain any two points p1 and p2
	// that have the same value for `min(abs(p.x), abs(p.y))`.
	// This means that from all points, we can select at most one point for each unique
	// `min(abs(p.x), abs(p.y))` value.
	// To maximize the number of points, we should try to select one point for every
	// unique `min(abs(p.x), abs(p.y))` value present in the input.
	//
	// For each unique `val` (key in minLForVal), we have already found the point
	// that requires the smallest `L` (value in minLForVal).
	// Let `L_max_required = max(all_values_in_minLForVal)`.
	// A square of side `2 * L_max_required` will contain exactly `len(minLForVal)` points,
	// one for each unique `val`, and this is the maximum possible number of points
	// that satisfies the condition.
	// The tie-breaking rule (minimum side length for same max points) is implicitly handled
	// because we always consider the point that requires the smallest `L` for each `val`.
	// Thus, the answer is simply the count of unique `val`s we found.

	return len(minLForVal)
}