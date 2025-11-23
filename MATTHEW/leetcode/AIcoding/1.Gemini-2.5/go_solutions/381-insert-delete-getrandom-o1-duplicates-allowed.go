type RandomizedCollection struct {
	vals    []int                      // Stores all elements, including duplicates
	indices map[int]map[int]struct{} // val -> set of indices in 'vals' where val appears
	randGen *rand.