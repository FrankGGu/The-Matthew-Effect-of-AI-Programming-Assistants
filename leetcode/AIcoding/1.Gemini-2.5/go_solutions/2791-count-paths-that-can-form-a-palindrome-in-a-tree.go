func countPalindromePaths(parent []int, s string) int64 {
	n := len(parent)
	adj := make([][]int, n)
	root := 0

	// Build adjacency list. The problem states `parent[i]` is the parent of node `i`.
	// Node 0 is always the