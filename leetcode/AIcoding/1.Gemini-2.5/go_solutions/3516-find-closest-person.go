func maxDistToClosest(seats []int) int {
	n := len(seats)
	left := make([]int, n)
	right := make([]int, n)

	// Initialize with a value indicating no person found yet
	// A value larger than any possible distance (n) or -1 works.
	// Using n for simplicity