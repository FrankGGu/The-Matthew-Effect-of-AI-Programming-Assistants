package main

import "math"

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maximumWhiteTiles(tiles [][]int, carpetLen int) int64 {
	n := len(tiles)
	if n == 0 {
		return 0
	}

	maxCover := int64(0)
	currentCovered := int64(0)
	i := 0 // Left pointer for the sliding window of tiles

	carpetLen64 := int64(carpetLen) // Convert carpetLen to int64 for calculations

	for j := 0; j < n; j++ { // Right pointer for the sliding window of tiles
		// Add the current tile's length to the total covered length in the window
		currentCovered += int64(tiles[j][1] - tiles[j][0] + 1)

		// Calculate the leftmost possible start position for a carpet of length carpetLen
		// that ends at tiles[j][1].
		carpetStartPos := int64(tiles[j][1]) - carpetLen64 + 1

		// Shrink the window from the left (increment i) if tiles[i] is entirely to the left
		// of where the carpet must start to cover tiles[j] and have length carpetLen.
		// That is, if tiles[i] ends before carpetStartPos.
		for int64(tiles[i][1]) < carpetStartPos {
			currentCovered -= int64(tiles[i][1] - tiles[i][0] + 1)
			i++
		}

		// At this point, tiles[i] is the first tile that either starts at or after carpetStartPos,
		// OR tiles[i] overlaps with carpetStartPos.
		// The currentCovered includes all tiles from tiles[i] to tiles[j].

		// Calculate the actual coverage for the carpet ending at tiles[j][1] and starting at carpetStartPos.
		// If tiles[i] starts before carpetStartPos, then a portion of tiles[i] is not covered by this carpet placement.
		// This portion is (carpetStartPos - tiles[i][0]).
		// We subtract this uncovered portion from currentCovered to get the effective coverage for this specific carpet placement.
		currentWindowCoverage := currentCovered
		if int64(tiles[i][0]) < carpetStartPos {
			currentWindowCoverage -= (carpetStartPos - int64(tiles[i][0]))
		}

		maxCover = max(maxCover, currentWindowCoverage)
	}

	return maxCover
}