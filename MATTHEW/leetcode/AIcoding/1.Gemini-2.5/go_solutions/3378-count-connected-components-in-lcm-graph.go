type DSU struct {
	parent []int
	rank   []int
	count  int // Number of disjoint sets
}

func NewDSU(n int) *DSU