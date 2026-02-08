import "sort"

func distanceLimitedPathsExist(n int, edgeList [][]int, queries [][]int) []bool {
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
		if rootI != rootJ {
			parent[rootI] = rootJ
		}
	}

	sort.Slice(edgeList, func(i, j int) bool {
		return edgeList[i][2] < edgeList[j][2]
	})

	m := len(queries)
	result := make([]bool, m)
	queryIndices := make([]int, m)
	for i := 0; i < m; i++ {
		queryIndices[i] = i
	}

	sort.Slice(queryIndices, func(i, j int) bool {
		return queries[queryIndices[i]][2] < queries[queryIndices[j]][2]
	})

	edgeIndex := 0
	for _, queryIndex := range queryIndices {
		threshold := queries[queryIndex][2]
		u := queries[queryIndex][0]
		v := queries[queryIndex][1]

		for edgeIndex < len(edgeList) && edgeList[edgeIndex][2] < threshold {
			edge := edgeList[edgeIndex]
			union(edge[0], edge[1])
			edgeIndex++
		}

		result[queryIndex] = find(u) == find(v)
	}

	return result
}