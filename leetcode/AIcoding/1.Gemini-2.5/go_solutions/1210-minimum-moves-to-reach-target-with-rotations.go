func minimumMoves(grid [][]int) int {
	n := len(grid)

	type State struct {
		r, c int // (r, c) is the top-left cell of the snake
		orientation int // 0 for horizontal (r,c) and (r,c+1), 1 for vertical (r,c