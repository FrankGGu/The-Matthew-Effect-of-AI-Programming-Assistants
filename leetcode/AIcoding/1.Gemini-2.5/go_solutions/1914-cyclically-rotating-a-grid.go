package main

func rotateGrid(grid [][]int, k int) [][]int {
	m := len(grid)
	n := len(grid[0])

	for l := 0; l < m/2 && l < n/2; l++ {
		rStart := l
		rEnd := m - 1 - l
		cStart := l
		cEnd := n - 1 - l

		layerElements := []int{}

		// Extract elements of the current layer into a 1D slice
		// Top row (left to right)
		for c := cStart; c <= cEnd; c++ {
			layerElements = append(layerElements, grid[rStart][c])
		}
		// Right column (top to bottom, excluding top-right corner)
		for r := rStart + 1; r <= rEnd; r++ {
			layerElements = append(layerElements, grid[r][cEnd])
		}
		// Bottom row (right to left, excluding bottom-right corner)
		// This loop only runs if there is more than one row in the layer
		if rStart != rEnd {
			for c := cEnd - 1; c >= cStart; c-- {
				layerElements = append(layerElements, grid[rEnd][c])
			}
		}
		// Left column (bottom to top, excluding bottom-left and top-left corners)
		// This loop only runs if there is more than one column in the layer
		if cStart != cEnd {
			for r := rEnd - 1; r > rStart; r-- {
				layerElements = append(layerElements, grid[r][cStart])
			}
		}

		numElements := len(layerElements)
		if numElements == 0 {
			continue
		}

		effectiveK := k % numElements

		// Perform counter-clockwise rotation (left shift)
		rotatedLayerElements := append(layerElements[effectiveK:], layerElements[:effectiveK]...)

		// Place rotated elements back into the grid
		idx := 0

		// Top row (left to right)
		for c := cStart; c <= cEnd; c++ {
			grid[rStart][c] = rotatedLayerElements[idx]
			idx++
		}
		// Right column (top to bottom, excluding top-right corner)
		for r := rStart + 1; r <= rEnd; r++ {
			grid[r][cEnd] = rotatedLayerElements[idx]
			idx++
		}
		// Bottom row (right to left, excluding bottom-right corner)
		if rStart != rEnd {
			for c := cEnd - 1; c >= cStart; c-- {
				grid[rEnd][c] = rotatedLayerElements[idx]
				idx++
			}
		}
		// Left column (bottom to top, excluding bottom-left and top-left corners)
		if cStart != cEnd {
			for r := rEnd - 1; r > rStart; r-- {
				grid[r][cStart] = rotatedLayerElements[idx]
				idx++
			}
		}
	}

	return grid
}