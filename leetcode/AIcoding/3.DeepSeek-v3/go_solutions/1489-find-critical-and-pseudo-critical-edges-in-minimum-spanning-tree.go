import (
	"sort"
)

type UnionFind struct {
	parent []int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	for i := range parent {
		parent[i] = i
	}
	return &UnionFind{parent}
}

func (uf *UnionFind) Find(u int) int {
	if uf.parent[u] != u {
		uf.parent[u] = uf.Find(uf.parent[u])
	}
	return uf.parent[u]
}

func (uf *UnionFind) Union(u, v int) bool {
	pu, pv := uf.Find(u), uf.Find(v)
	if pu == pv {
		return false
	}
	uf.parent[pu] = pv
	return true
}

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	m := len(edges)
	for i := range edges {
		edges[i] = append(edges[i], i)
	}
	sort.Slice(edges, func(i, j int) bool {
		return edges[i][2] < edges[j][2]
	})

	uf := NewUnionFind(n)
	mstWeight := 0
	for _, edge := range edges {
		if uf.Union(edge[0], edge[1]) {
			mstWeight += edge[2]
		}
	}

	critical := []int{}
	pseudoCritical := []int{}

	for i := 0; i < m; i++ {
		uf := NewUnionFind(n)
		weight := 0
		for j, edge := range edges {
			if i != j && uf.Union(edge[0], edge[1]) {
				weight += edge[2]
			}
		}
		if uf.Find(0) != uf.Find(n-1) || weight > mstWeight {
			critical = append(critical, edges[i][3])
			continue
		}

		uf = NewUnionFind(n)
		uf.Union(edges[i][0], edges[i][1])
		weight = edges[i][2]
		for j, edge := range edges {
			if i != j && uf.Union(edge[0], edge[1]) {
				weight += edge[2]
			}
		}
		if weight == mstWeight {
			pseudoCritical = append(pseudoCritical, edges[i][3])
		}
	}

	res := make([][]int, 2)
	res[0] = critical
	res[1] = pseudoCritical
	return res
}