type State struct {
	node int
	mask int
	dist int
}

func shortestPathLength(graph [][]int) int {
	n := len(graph)
	if n == 1 {
		return 0
	}

	allVisitedMask := (