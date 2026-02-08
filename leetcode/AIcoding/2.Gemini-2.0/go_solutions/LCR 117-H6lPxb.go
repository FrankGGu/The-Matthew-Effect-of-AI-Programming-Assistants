func numSimilarGroups(strs []string) int {
	n := len(strs)
	parent := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
	}

	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
		}
	}

	areSimilar := func(s1, s2 string) bool {
		diff := 0
		for i := 0; i < len(s1); i++ {
			if s1[i] != s2[i] {
				diff++
			}
		}
		return diff == 0 || diff == 2
	}

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if areSimilar(strs[i], strs[j]) {
				union(i, j)
			}
		}
	}

	count := 0
	for i := 0; i < n; i++ {
		if parent[i] == i {
			count++
		}
	}

	return count
}