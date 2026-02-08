const (
	// maxLevel defines the maximum number of levels a skiplist can have.
	// A common heuristic is log_1/p(N) where N is the max expected number of elements.
	// For N=20000 (