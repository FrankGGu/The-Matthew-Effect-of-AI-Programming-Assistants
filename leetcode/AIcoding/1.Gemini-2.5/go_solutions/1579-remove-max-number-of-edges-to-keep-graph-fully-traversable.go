type DSU struct {
	parent     []int
	components int
}

func newDSU(n int) *DSU {
	parent := make([]int, n+1) // Nodes are 1-indexed
	for i := 1; i <= n; i++ {
		parent[i] = i
	}