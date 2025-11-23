func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
	rows := len(image)
	cols := len(image[0])
	oldColor := image[sr][sc]

	if oldColor == newColor {
		return image
	}

	var dfs func(int, int)
	dfs = func(row, col int) {
		if row < 0 || row >= rows || col < 0 || col >= cols || image[row][col] != oldColor {
			return
		}

		image[row][col] = newColor
		dfs(row+1, col)
		dfs(row-1, col)
		dfs(row, col+1)
		dfs(row, col-1)
	}

	dfs(sr, sc)
	return image
}