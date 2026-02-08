func minCost(grid []string, startRow int, startCol int, endRow int, endCol int) int {
	m, n := len(grid), len(grid[0])
	cost := make([][]int, m)
	for i := range cost {
		cost[i] = make([]int, n)
		for j := range cost[i] {
			cost[i][j] = -1
		}
	}
	cost[startRow][startCol] = 0
	queue := [][]int{{startRow, startCol}}
	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]
		row, col := curr[0], curr[1]
		currCost := cost[row][col]
		for _, dir := range directions {
			newRow, newCol := row+dir[0], col+dir[1]
			if newRow >= 0 && newRow < m && newCol >= 0 && newCol < n {
				expectedDir := ""
				if dir[0] == 0 && dir[1] == 1 {
					expectedDir = "R"
				} else if dir[0] == 0 && dir[1] == -1 {
					expectedDir = "L"
				} else if dir[0] == 1 && dir[1] == 0 {
					expectedDir = "D"
				} else {
					expectedDir = "U"
				}
				newCost := currCost
				if string(grid[row][col]) != expectedDir {
					newCost++
				}
				if cost[newRow][newCol] == -1 || newCost < cost[newRow][newCol] {
					cost[newRow][newCol] = newCost
					queue = append(queue, []int{newRow, newCol})
				}
			}
		}
	}
	return cost[endRow][endCol]
}