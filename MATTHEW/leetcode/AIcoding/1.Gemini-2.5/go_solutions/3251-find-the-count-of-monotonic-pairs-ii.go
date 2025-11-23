type FenwickTree struct {
	size int
	tree []int
}

func NewFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		size: size,
		tree: make([]int,