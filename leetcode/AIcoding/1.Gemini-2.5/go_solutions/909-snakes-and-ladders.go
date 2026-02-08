package main

func snakesAndLadders(board [][]int) int {
	n := len(board)
	totalSquares := n * n
	queue := []int{1}
	visited := make(map[int]bool)
	visited[1] = true
	moves := 0

	for len(queue) > 0 {
		levelSize := len(queue)
		for i := 0; i < levelSize; i++ {
			currentSquare := queue[0]
			queue = queue[1:]

			if currentSquare == totalSquares {
				return moves
			}

			for nextStep := 1; nextStep <= 6; nextStep++ {
				nextSquare := currentSquare + nextStep
				if nextSquare > totalSquares {
					continue
				}

				// Calculate board coordinates for nextSquare
				rIdx := (nextSquare - 1) / n // 0-indexed row from the bottom
				cIdx := (nextSquare - 1) % n // 0-indexed column from the left

				row := n - 1 - rIdx // Actual 0-indexed row in the 2D array (from top)
				col := cIdx         // Actual 0-indexed column in the 2D array
				if rIdx%2 != 0 {    // If it's an odd row from the bottom (zig-zag right-to-left)
					col = n - 1 - cIdx
				}

				finalSquare := nextSquare
				if board[row][col] != -1 {
					finalSquare = board[row][col]
				}

				if !visited[finalSquare] {
					visited[finalSquare] = true
					queue = append(queue, finalSquare)
				}
			}
		}
		moves++
	}

	return -1
}