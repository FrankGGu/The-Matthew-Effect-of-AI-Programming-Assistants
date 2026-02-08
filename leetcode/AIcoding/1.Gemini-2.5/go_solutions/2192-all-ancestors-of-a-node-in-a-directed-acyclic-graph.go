func getAncestors(n int, edges [][]int) [][]int {
	// Build the adjacency list for the reverse graph.
	// adjRev[i] will contain all nodes j such that there is an edge j -> i in the original graph.
	adjRev := make([][]int