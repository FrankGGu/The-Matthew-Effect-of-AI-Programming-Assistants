import (
	"sort"
)

type DSU struct {
	parent []int
	rank   []int
}

func newDSU(n int) *DSU {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}
	rank := make([]int, n)
	return &DSU{parent: parent, rank: rank}
}

func (d *DSU) find(i int) int {
	if d.parent[i] == i {
		return i
	}
	d.parent[i] = d.find(d.parent[i])
	return d.parent[i]
}

func (d *DSU) union(i, j int) bool {
	rootI := d.find(i)
	rootJ := d.find(j)

	if rootI != rootJ {
		if d.rank[rootI] < d.rank[rootJ] {
			d.parent[rootI] = rootJ
		} else if d.rank[rootI] > d.rank[rootJ] {
			d.parent[rootJ] = rootI
		} else {
			d.parent[rootJ] = rootI
			d.rank[rootI]++
		}
		return true
	}
	return false
}

type query struct {
	u, v, limit, originalIndex int
}

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
	sortedQueries := make([]query, len(queries))
	for i, q := range queries {
		sortedQueries[i] = query{u: q[0], v: q[1], limit: q[2], originalIndex: i}
	}

	sort.Slice(sortedQueries, func(i, j int) bool {
		return sortedQueries[i].limit < sortedQueries[j].limit
	})

	sort.Slice(edgeList, func(i, j int) bool {
		return edgeList[i][2] < edgeList[j][2]
	})

	dsu := newDSU(n)
	results := make([]bool, len(queries))
	edgeIdx := 0

	for _, q := range sortedQueries {
		for edgeIdx < len(edgeList) && edgeList[edgeIdx][2] < q.limit {
			dsu.union(edgeList[edgeIdx][0], edgeList[edgeIdx][1])
			edgeIdx++
		}
		results[q.originalIndex] = dsu.find(q.u) == dsu.find(q.v)
	}

	return results
}