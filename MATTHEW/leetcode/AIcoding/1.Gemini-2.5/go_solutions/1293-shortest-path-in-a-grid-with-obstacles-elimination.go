type State struct {
	r, c, k_left, steps int
}

func shortestPath(grid [][]int, k int) int {
	m := len(grid)
	n := len(grid[0])

	// Optimization: If k is large enough to clear all obstacles on any shortest path (Manhattan distance),