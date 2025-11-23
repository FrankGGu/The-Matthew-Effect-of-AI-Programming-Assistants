func findDiagonalOrder(mat [][]int) []int {
	m := len(mat)
	if m == 0 {
		return []int{}
	}
	n := len(mat[0])
	if n == 0 {
		return []int{}
	}

	result := make([]int, m*n)
	r, c := 0, 0
	// dir: 1 for up-right (r--, c++), -1 for down-left (r++, c--)
	dir := 1

	for k := 0; k < m*n; k++ {
		result[k] = mat[r][c]

		if dir == 1 { // Moving up-right
			// Try to move up-right
			r--
			c++

			// Check boundaries and adjust position/direction
			if r < 0 && c >= n { // Hit top-right corner
				r += 2 // Move down two steps from previous r
				c--    // Move left one step from previous c
				dir = -1
			} else if r < 0 { // Hit top wall
				r = 0 // Stay on top
				dir = -1
			} else if c >= n { // Hit right wall
				c = n - 1 // Stay on right
				r += 2    // Move down two steps from previous r
				dir = -1
			}
		} else { // Moving down-left
			// Try to move down-left
			r++
			c--

			// Check boundaries and adjust position/direction
			if r >= m && c < 0 { // Hit bottom-left corner
				c += 2 // Move right two steps from previous c
				r--    // Move up one step from previous r
				dir = 1
			} else if r >= m { // Hit bottom wall
				r = m - 1 // Stay on bottom
				c += 2    // Move right two steps from previous c
				dir = 1
			} else if c < 0 { // Hit left wall
				c = 0 // Stay on left
				dir = 1
			}
		}
	}
	return result
}