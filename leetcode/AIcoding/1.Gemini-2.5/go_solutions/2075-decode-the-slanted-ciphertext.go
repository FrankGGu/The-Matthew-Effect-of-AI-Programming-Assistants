import (
	"strings"
)

func decodeCiphertext(encodedText string, rows int) string {
	n := len(encodedText)
	if n == 0 {
		return ""
	}

	// According to the problem description on LeetCode, "It is guaranteed that len(encodedText) is a multiple of rows."
	// This allows us to determine the number of columns directly.
	cols := n / rows

	// Create a grid to reconstruct the original text.
	// Initialize with spaces, as empty cells in the original text are implicitly spaces.
	grid := make([][]byte, rows)
	for i := range grid {
		grid[i] = make([]byte, cols)
		for j := range grid[i] {
			grid[i][j] = ' '
		}
	}

	encodedTextIdx := 0
	// Iterate through starting columns of diagonals (jStart from 0 to cols-1)
	for jStart := 0; jStart < cols; jStart++ {
		// Iterate along the current diagonal (k represents the step down the diagonal)
		for k := 0; ; k++ {
			r := k                 // Current row index
			c := jStart + k        // Current column index

			// Check if the current cell (r, c) is within the grid boundaries
			if r < rows && c < cols {
				// Place the character from encodedText into the grid
				// Ensure we don't read beyond encodedText length, though this should not happen
				// if encodedText length perfectly matches the sum of diagonal cells.
				if encodedTextIdx < n {
					grid[r][c] = encodedText[encodedTextIdx]
					encodedTextIdx++
				} else {
					// This break handles cases where encodedText might be shorter than expected
					// for the calculated grid size, though problem constraints suggest it won't.
					break
				}
			} else {
				// The diagonal has gone out of bounds, move to the next starting column
				break
			}
		}
	}

	// Reconstruct the original text by reading the grid row by row
	var sb strings.Builder
	sb.Grow(rows * cols) // Pre-allocate capacity for efficiency
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			sb.WriteByte(grid[r][c])
		}
	}

	// The problem states: "The original text does not have leading or trailing spaces."
	// "The encoded text may have trailing spaces, which should be ignored."
	// This implies the final decoded string should have trailing spaces removed.
	return strings.TrimRight(sb.String(), " ")
}