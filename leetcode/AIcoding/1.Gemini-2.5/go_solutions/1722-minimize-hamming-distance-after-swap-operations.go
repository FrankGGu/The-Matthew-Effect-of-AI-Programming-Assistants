type DSU struct {
	parent []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &DSU{parent: parent}
}