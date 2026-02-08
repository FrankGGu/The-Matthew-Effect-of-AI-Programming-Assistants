import "container/list"

func maxDistance(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	queue := list.New()
	landCount := 0

	// Initialize queue with all land cells and count land cells
	for r := 0; r <