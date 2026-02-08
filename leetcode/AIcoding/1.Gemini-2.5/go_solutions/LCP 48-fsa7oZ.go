type BIT struct {
	data []int
	size int
}

func newBIT(size int) *BIT {
	return &BIT{
		data: make([]int, size+1),
		size: size,
	}
}