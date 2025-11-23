func largestIsland(grid [][]int) int {
	n := len(grid)
	m := len(grid[0])

	// islandId starts from 2 to distinguish from 0 (water) and 1 (unvisited land)
	islandId := 2