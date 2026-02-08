type FenwickTree struct {
	size int
	tree []int64 // Stores sum of values
	cnt  []int64 // Stores count of elements
}

func