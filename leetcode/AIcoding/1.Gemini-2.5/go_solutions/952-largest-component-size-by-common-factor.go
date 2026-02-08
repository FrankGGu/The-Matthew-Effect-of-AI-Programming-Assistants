type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n