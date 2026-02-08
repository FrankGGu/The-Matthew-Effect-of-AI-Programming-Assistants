import "math"

func shortestDistance(words []string, target string, startIndex int) int {
	n := len(words)
	minDist := n // Initialize with a value larger than any possible distance

	for i := 0; i < n; i++ {
		if words[i] == target {
			// Calculate linear distance between current index i and startIndex
			diff := int(math.Abs(float64(i - startIndex)))

			// Calculate circular distance
			// The shortest path in a circle is the minimum of the two possible directions
			// (clockwise or counter-clockwise).
			// One direction is 'diff', the other is 'n - diff'.
			currentDist := int(math.Min(float64(diff), float64(n-diff)))

			// Update the overall minimum distance found so far
			minDist = int(math.Min(float64(minDist), float64(currentDist)))
		}
	}

	return minDist
}