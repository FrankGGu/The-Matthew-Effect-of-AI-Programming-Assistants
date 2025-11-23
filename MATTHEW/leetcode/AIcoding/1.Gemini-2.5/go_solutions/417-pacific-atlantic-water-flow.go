func pacificAtlantic(heights [][]int) [][]int {
	m := len(heights)
	if m == 0 {
		return [][]int{}
	}
	n := len(heights[0])
	if n == 0 {
		return [][]int{}
	}

	canReach