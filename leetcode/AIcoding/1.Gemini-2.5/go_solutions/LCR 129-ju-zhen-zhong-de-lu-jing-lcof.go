func exist(board [][]byte, word string) bool {
	rows := len(board)
	if rows == 0 {
		return false
	}
	cols := len(board[0])
	if cols == 0 {
		return false
	}

	wordBytes := []byte(word)
	if len(wordBytes) == 0 {
		return true // An empty word is considered to always exist
	}

	var dfs func(r, c, k int) bool
	dfs = func(r, c, k int) bool {
		// Base case: If we've matched all characters in the word
		if k == len(wordBytes) {
			return true
		}

		// Boundary conditions, character mismatch, or already visited cell
		if r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != wordBytes[k] {
			return false
		}

		// Mark the current cell as visited by changing its character
		// Use a character that won't appear in the word, e.g., '#' or '*'
		originalChar := board[r][c]
		board[r][c] = '#' // Mark as visited

		// Explore neighbors (up, down, left, right)
		if dfs(r+1, c, k+1) ||
			dfs(r-1, c, k+1) ||
			dfs(r, c+1, k+1) ||
			dfs(r, c-1, k+1) {
			return true
		}

		// Backtrack: Unmark the current cell to allow other paths to use it
		board[r][c] = originalChar
		return false
	}

	// Iterate through each cell of the board as a potential starting point
	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if board[r][c] == wordBytes[0] { // Only start DFS if the first character matches
				if dfs(r, c, 0) {
					return true
				}
			}
		}
	}

	return false
}