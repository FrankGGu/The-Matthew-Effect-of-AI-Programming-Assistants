type SegTree struct {
	tree []int
	size int
}

func newSegTree(n int) *SegTree {
	size := 1
	for size < n {
		size *=