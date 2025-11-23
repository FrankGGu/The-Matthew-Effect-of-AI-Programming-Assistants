func eventualSafeNodes(graph [][]int) []int {
	n := len(graph)
	// states:
	// 0: unvisited
	// 1: visiting (currently in the recursion stack, potentially part of a cycle)
	// 2: safe (all paths from this node lead to terminal nodes)