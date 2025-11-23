func findZigzagTraversal(grid [][]int) []int {
	if len(grid) == 0 || len(grid[0]) == 0 {
		return []int{}
	}

	m := len(grid)
	n := len(grid[0])
	result := make([]int, 0, m*n)

	row, col := 0, 0
	direction := 1 // 1 for up-right, -1 for down-left

	for i := 0; i < m*n; i++ {
		// This is where a "skip" condition would be applied if specified.
		// For example, if the problem required skipping elements with value 0:
		// if grid[row][col] != 0 {
		//     result = append(result, grid[row][col])
		// }
		// Without a specific skip rule, all elements are included in the traversal.
		result = append(result, grid[row][col])

		if direction == 1 { // Moving up-right
			nextRow, nextCol := row-1, col+1
			if nextRow < 0 || nextCol >= n { // Hit boundary
				direction = -1 // Change to down-left
				if nextCol >= n { // Hit right boundary, move down
					row++
				} else { // Hit top boundary, move right
					col++
				}
			} else { // Continue up-right
				row, col = nextRow, nextCol
			}
		} else { // Moving down-left
			nextRow, nextCol := row+1, col-1
			if nextRow >= m || nextCol < 0 { // Hit boundary
				direction = 1 // Change to up-right
				if nextRow >= m { // Hit bottom boundary, move right
					col++
				} else { // Hit left boundary, move down
					row++
				}
			} else { // Continue down-left
				row, col = nextRow, nextCol
			}
		}
	}

	return result
}