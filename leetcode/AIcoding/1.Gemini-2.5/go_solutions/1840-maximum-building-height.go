package main

import (
	"sort"
)

func maxBuilding(n int, restrictions [][]int) int {
	// 1. Create a new slice `allRestrictions`. Add `[1, 0]` (building at pos 1 must have height 0).
	// 2. Add all given `restrictions` to `allRestrictions`.
	allRestrictions := make([][]int, len(restrictions)+1)
	allRestrictions[0] = []int{1, 0}
	for i, r := range restrictions {
		allRestrictions[i+1] = r
	}

	// 3. Sort `allRestrictions` by `pos`.
	sort.Slice(allRestrictions, func(i, j int) bool {
		return allRestrictions[i][0] < allRestrictions[j][0]
	})

	// 4. Left to right pass: Adjust heights based on previous building's height and position.
	// A building's height cannot exceed the previous building's height plus the distance between them.
	for i := 1; i < len(allRestrictions); i++ {
		prevPos := allRestrictions[i-1][0]
		prevHeight := allRestrictions[i-1][1]
		currPos := allRestrictions[i][0]
		currHeight := allRestrictions[i][1]

		allRestrictions[i][1] = min(currHeight, prevHeight+(currPos-prevPos))
	}

	// 5. Right to left pass: Adjust heights based on next building's height and position.
	// A building's height cannot exceed the next building's height plus the distance between them.
	for i := len(allRestrictions) - 2; i >= 0; i-- {
		nextPos := allRestrictions[i+1][0]
		nextHeight := allRestrictions[i+1][1]
		currPos := allRestrictions[i][0]
		currHeight := allRestrictions[i][1]

		allRestrictions[i][1] = min(currHeight, nextHeight+(nextPos-currPos))
	}

	// 6. Initialize `maxHeight` to 0.
	maxHeight := 0

	// 7. Iterate through adjacent pairs of restricted buildings to find the maximum possible height
	// for any building *between* them (including the restricted buildings themselves).
	for i := 0; i < len(allRestrictions)-1; i++ {
		p1 := allRestrictions[i][0]
		h1 := allRestrictions[i][1]
		p2 := allRestrictions[i+1][0]
		h2 := allRestrictions[i+1][1]

		diffPos := p2 - p1
		// The maximum height between p1 and p2, respecting the height limits h1 and h2
		// and the slope constraint, is given by (h1 + h2 + diffPos) / 2.
		// This formula correctly calculates the peak height in the "triangle" formed.
		peakHeight := (h1 + h2 + diffPos) / 2
		maxHeight = max(maxHeight, peakHeight)
	}

	// 8. Consider the segment from the last restricted building to the final building 'n'.
	// The height can continue to increase by at most 1 for each unit of position.
	lastRestriction := allRestrictions[len(allRestrictions)-1]
	lastPos := lastRestriction[0]
	lastHeight := lastRestriction[1]

	// The maximum height for any building from lastPos to n is lastHeight + (n - lastPos).
	maxHeight = max(maxHeight, lastHeight+(n-lastPos))

	// 9. Return the overall maximum height found.
	return maxHeight
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