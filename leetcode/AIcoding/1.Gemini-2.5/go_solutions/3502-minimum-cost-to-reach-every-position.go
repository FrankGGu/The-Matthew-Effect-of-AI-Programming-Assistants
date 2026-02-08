import (
	"sort"
)

type UnionFind struct {
	parent []int
	rank   []int
}

func NewUnionFind(n int) *UnionFind {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	rank := make([]int, n)
	return &UnionFind{parent: parent, rank: rank}
}

func (uf *UnionFind) Find(i int) int {
	if uf.parent[i] == i {
		return i
	}
	uf.parent[i] = uf.Find(uf.parent[i])
	return uf.parent[i]
}

func (uf *UnionFind) Union(i, j int) bool {
	rootI := uf.Find(i)
	rootJ := uf.Find(j)

	if rootI != rootJ {
		if uf.rank[rootI] < uf.rank[rootJ] {
			uf.parent[rootI] = rootJ
		} else if uf.rank[rootI] > uf.rank[rootJ] {
			uf.parent[rootJ] = rootI
		} else {
			uf.parent[rootJ] = rootI
			uf.rank[rootI]++
		}
		return true
	}
	return false
}

type Edge struct {
	cost int
	p1   int
	p2   int
}

type ByCost []Edge

func (a ByCost) Len() int           { return len(a) }
func (a ByCost) Swap(i, j int)      { a[i], a[j] = a[j], a[i] }
func (a ByCost) Less(i, j int) bool { return a[i].cost < a[j].cost }

func minCostConnectPoints(points [][]int) int {
	n := len(points)
	if n <= 1 {
		return 0
	}

	edges := []Edge{}
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			cost := abs(points[i][0]-points[j][0]) + abs(points[i][1]-points[j][1])
			edges = append(edges, Edge{cost, i, j})
		}
	}

	sort.Sort(ByCost(edges))

	uf := NewUnionFind(n)
	minCost := 0
	edgesCount := 0

	for _, edge := range edges {
		if uf.Union(edge.p1, edge.p2) {
			minCost += edge.cost
			edgesCount++
			if edgesCount == n-1 {
				break
			}
		}
	}

	return minCost
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}