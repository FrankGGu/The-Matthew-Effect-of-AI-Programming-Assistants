func shiftGrid(grid [][]int, k int) [][]int {
	rows := len(grid)
	cols := len(grid[0])

	// Create a new grid to store the shifted elements
	newGrid := make([][]int, rows)
	for i := range newGrid {
		newGrid[i] = make([]int, cols)
	}

	totalElements := rows * cols

	// Iterate through the original grid
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			// Calculate the 1D index of the current element
			original1DIndex := r*cols + c

			// Calculate the 1D index after shifting k times
			// The modulo totalElements handles wrapping around and k being larger than totalElements
			shifted1DIndex := (original1DIndex + k) % totalElements

			// Convert the new 1D index back to 2D coordinates
			newR := shifted1DIndex / cols
			newC := shifted1DIndex % cols

			// Place the element from the original grid into its new position in newGrid
			newGrid[newR][newC] = grid[r][c]
		}
	}

	return newGrid
}