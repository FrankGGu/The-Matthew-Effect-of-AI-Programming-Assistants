func minSwapsCouples(row []int) int {
	n := len(row) / 2
	uf := NewUnionFind(n)
	for i := 0; i < n; i++ {
		a := row[2*i]
		b := row[2*i+1]
		uf.Union(a/2, b/2)
	}

	return n - uf.Count()
}

type UnionFind struct {
	parent []int
	count  int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	return &UnionFind{parent: parent, count: n}
}

func (uf *UnionFind) Find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.Find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
	rootX := uf.Find(x)
	rootY := uf.Find(y)
	if rootX != rootY {
		uf.parent[rootX] = rootY
		uf.count--
	}
}

func (uf *UnionFind) Count() int {
	return uf.count
}

func main() {}