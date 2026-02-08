func average(arr []int) int {
	sum := 0
	for _, num := range arr {
		sum += num
	}
	return sum / len(arr)
}

func averageColor(image [][]int, i, j, m, n int) (int, int, int) {
	colors := make(map[int][]int)
	visited := make([][]bool, m)
	for k := range visited {
		visited[k] = make([]bool, n)
	}

	var dfs func(i, j int)
	dfs = func(i, j int) {
		if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || image[i][j] == 0 {
			return
		}

		visited[i][j] = true
		if _, ok := colors[image[i][j]]; !ok {
			colors[image[i][j]] = []int{}
		}
		colors[image[i][j]] = append(colors[image[i][j]], image[i][j])

		dfs(i+1, j)
		dfs(i-1, j)
		dfs(i, j+1)
		dfs(i, j-1)
	}

	dfs(i, j)

	r := average(colors[image[i][j]])
	g := average(colors[image[i][j]])
	b := average(colors[image[i][j]])

	return r, g, b
}

func colorBorder(image [][]int, row int, col int, color int) [][]int {
	m := len(image)
	n := len(image[0])
	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}
	originalColor := image[row][col]

	var dfs func(i, j int)
	dfs = func(i, j int) {
		if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || image[i][j] != originalColor {
			return
		}

		visited[i][j] = true
		isBorder := i == 0 || i == m-1 || j == 0 || j == n-1 ||
			image[i+1][j] != originalColor || image[i-1][j] != originalColor ||
			image[i][j+1] != originalColor || image[i][j-1] != originalColor

		if isBorder {
			image[i][j] = color
		}

		dfs(i+1, j)
		dfs(i-1, j)
		dfs(i, j+1)
		dfs(i, j-1)
	}

	dfs(row, col)
	return image
}

func colorRegion(image [][]int, i, j, m, n, r, g, b int, visited [][]bool) {
	if i < 0 || i >= m || j < 0 || j >= n || visited[i][j] || image[i][j] == 0 {
		return
	}

	visited[i][j] = true
	image[i][j] = (r << 16) + (g << 8) + b

	colorRegion(image, i+1, j, m, n, r, g, b, visited)
	colorRegion(image, i-1, j, m, n, r, g, b, visited)
	colorRegion(image, i, j+1, m, n, r, g, b, visited)
	colorRegion(image, i, j-1, m, n, r, g, b, visited)
}

func findGrid(image [][]int) [][]int {
	m := len(image)
	n := len(image[0])
	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
		for j := range result[i] {
			result[i][j] = 0
		}
	}

	visited := make([][]bool, m)
	for i := range visited {
		visited[i] = make([]bool, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if image[i][j] != 0 && !visited[i][j] {
				r, g, b := averageColor(image, i, j, m, n)
				colorRegion(result, i, j, m, n, r, g, b, visited)

			}
		}
	}

	return result
}