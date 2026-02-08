import (
	"sort"
)

func findCriticalAndPseudoCriticalEdges(n int, edges [][]int) [][]int {
	m := len(edges)
	for i := 0; i < m; i++ {
		edges[i] = append(edges[i], i)
	}

	mstWeight := getMSTWeight(n, edges, -1, -1)

	critical := []int{}
	pseudoCritical := []int{}

	for i := 0; i < m; i++ {
		weightWithoutEdge := getMSTWeight(n, edges, i, -1)
		if weightWithoutEdge > mstWeight {
			critical = append(critical, edges[i][3])
		} else {
			weightWithEdge := getMSTWeight(n, edges, -1, i)
			if weightWithEdge == mstWeight {
				pseudoCritical = append(pseudoCritical, edges[i][3])
			}
		}
	}

	return [][]int{critical, pseudoCritical}
}

func getMSTWeight(n int, edges [][]int, excludeEdgeIndex int, includeEdgeIndex int) int {
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}

	var find func(int) int
	find = func(i int) int {
		if parent[i] == i {
			return i
		}
		parent[i] = find(parent[i])
		return parent[i]
	}

	union := func(i, j int) {
		rootI := find(i)
		rootJ := find(j)
		parent[rootI] = rootJ
	}

	mstWeight := 0
	numEdges := 0

	if includeEdgeIndex != -1 {
		u := edges[includeEdgeIndex][0]
		v := edges[includeEdgeIndex][1]
		w := edges[includeEdgeIndex][2]
		if find(u) != find(v) {
			union(u, v)
			mstWeight += w
			numEdges++
		}
	}

	sortedEdges := make([][]int, len(edges))
	copy(sortedEdges, edges)

	sort.Slice(sortedEdges, func(i, j int) bool {
		return sortedEdges[i][2] < sortedEdges[j][2]
	})

	for i := 0; i < len(sortedEdges); i++ {
		if i == excludeEdgeIndex || i == includeEdgeIndex {
			continue
		}
		u := sortedEdges[i][0]
		v := sortedEdges[i][1]
		w := sortedEdges[i][2]
		if find(u) != find(v) {
			union(u, v)
			mstWeight += w
			numEdges++
		}
	}

	if numEdges != n-1 {
		return int(1e9 + 7)
	}

	return mstWeight
}