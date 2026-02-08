type dsu struct {
	parent []int
	count  int
}

func newDSU(n int) *dsu {
	parent := make([]int, n+1)
	for i := 1; i <= n;