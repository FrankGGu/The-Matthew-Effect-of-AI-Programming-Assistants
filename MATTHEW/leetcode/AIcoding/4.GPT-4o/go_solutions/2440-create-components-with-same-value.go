type UnionFind struct {
	parent []int
	size   []int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}
	return &UnionFind{parent, size}
}

func (uf *UnionFind) find(x int) int {
	if uf.parent[x] != x {
		uf.parent[x] = uf.find(uf.parent[x])
	}
	return uf.parent[x]
}

func (uf *UnionFind) union(x, y int) {
	rootX := uf.find(x)
	rootY := uf.find(y)
	if rootX != rootY {
		if uf.size[rootX] < uf.size[rootY] {
			rootX, rootY = rootY, rootX
		}
		uf.parent[rootY] = rootX
		uf.size[rootX] += uf.size[rootY]
	}
}

func createComponents(n int, edges [][]int, values []int) int {
	uf := NewUnionFind(n)
	for _, edge := range edges {
		uf.union(edge[0], edge[1])
	}

	componentMap := make(map[int]int)
	for i := 0; i < n; i++ {
		root := uf.find(i)
		componentMap[root] += values[i]
	}

	count := 0
	for _, total := range componentMap {
		if total == values[uf.find(0)] {
			count++
		}
	}
	return count
}