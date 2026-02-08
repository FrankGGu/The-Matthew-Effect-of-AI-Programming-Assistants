package main

func pacificAtlantic(heights [][]int) [][]int {
	if len(heights) == 0 || len(heights[0]) == 0 {
		return [][]int{}
	}

	rows, cols := len(heights), len(heights[0])
	pacific := make([][]bool, rows)
	atlantic := make([][]bool, rows)

	for i := 0; i < rows; i++ {
		pacific[i] = make([]bool, cols)
		atlantic[i] = make([][]bool, cols)
	}

	var dfs func(i, j int, visited [][]bool, prevHeight int)
	dfs = func(i, j int, visited [][]bool, prevHeight int) {
		if i < 0 || i >= rows || j < 0 || j >= cols || visited[i][j] || heights[i][j] < prevHeight {
			return
		}
		visited[i][j] = true
		dfs(i+1, j, visited, heights[i][j])
		dfs(i-1, j, visited, heights[i][j])
		dfs(i, j+1, visited, heights[i][j])
		dfs(i, j-1, visited, heights[i][j])
	}

	for i := 0; i < rows; i++ {
		dfs(i, 0, pacific, -1)
		dfs(i, cols-1, atlantic, -1)
	}

	for j := 0; j < cols; j++ {
		dfs(0, j, pacific, -1)
		dfs(rows-1, j, atlantic, -1)
	}

	result := [][]int{}
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if pacific[i][j] && atlantic[i][j] {
				result = append(result, []int{i, j})
			}
		}
	}

	return result
}