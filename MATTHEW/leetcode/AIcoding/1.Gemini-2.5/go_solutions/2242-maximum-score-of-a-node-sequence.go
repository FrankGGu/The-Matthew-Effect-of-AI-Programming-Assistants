func maximumScore(scores []int, edges [][]int) int {
	n := len(scores)

	// Adjacency list: for each node, store its neighbors and their scores.
	// To optimize, we only store up to 3 neighbors with the highest scores.
	// This