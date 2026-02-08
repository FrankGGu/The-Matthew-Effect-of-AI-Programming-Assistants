func nearestExit(maze [][]byte, entrance []int) int {
	m, n := len(maze), len(maze[0])
	queue := [][]int{entrance}
	maze[entrance[0]][entrance[1]] = '+'
	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	steps := 0

	for len(queue) > 0 {
		steps++
		size := len(queue)
		for i := 0; i < size; i++ {
			curr := queue[0]
			queue = queue[1:]

			for _, dir := range directions {
				row := curr[0] + dir[0]
				col := curr[1] + dir[1]

				if row < 0 || row >= m || col < 0 || col >= n || maze[row][col] == '+' {
					continue
				}

				if row == 0 || row == m-1 || col == 0 || col == n-1 {
					return steps
				}

				maze[row][col] = '+'
				queue = append(queue, []int{row, col})
			}
		}
	}

	return -1
}