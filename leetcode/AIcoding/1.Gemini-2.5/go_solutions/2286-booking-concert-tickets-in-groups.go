type BookMyShow struct {
	n int
	m int

	// rowsOccupied[i] stores the number of seats already taken in row i.
	rowsOccupied []int

	// nextRowAvailableForGather is the smallest row index i such that rowsOccupied[i] < m.
	// It's an optimization to avoid