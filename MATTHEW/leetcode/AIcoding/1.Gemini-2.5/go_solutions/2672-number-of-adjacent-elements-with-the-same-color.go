func colorTheArray(n int, queries [][]int) []int {
	colors := make([]int, n)
	ans := make([]int, len(queries))
	currentAdjacentPairs := 0

	for i, query := range queries {
		idx := query[0]
		newColor := query[1]
		oldColor := colors[idx]

		// If the element was previously colored,
		// remove its contribution to adjacent pairs count.
		if oldColor != 0 {
			// Check left neighbor
			if idx > 0 && colors[idx-1] == oldColor {
				currentAdjacentPairs--
			}
			// Check right neighbor
			if idx < n-1 && colors[idx+1] == oldColor {
				currentAdjacentPairs--
			}
		}

		// Update the color of the element
		colors[idx] = newColor

		// Add new contribution to adjacent pairs count
		// Check left neighbor
		if idx > 0 && colors[idx-1] == newColor {
			currentAdjacentPairs++
		}
		// Check right neighbor
		if idx < n-1 && colors[idx+1] == newColor {
			currentAdjacentPairs++
		}

		ans[i] = currentAdjacentPairs
	}

	return ans
}