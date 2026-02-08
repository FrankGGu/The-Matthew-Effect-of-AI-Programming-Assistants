type DSU struct {
	parent []int
	// Stores the number of target nodes for the component rooted at index i
	targetCounts []int
	// Stores the number of nodes for the component rooted at index i
	// Although not