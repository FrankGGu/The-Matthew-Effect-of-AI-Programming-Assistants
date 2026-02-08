func smallestStringWithSwaps(s string, pairs [][]int) string {
	n := len(s)
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

	for _, pair := range pairs {
		union(pair[0], pair[1])
	}

	groups := make(map[int][]int)
	for i := 0; i < n; i++ {
		root := find(i)
		groups[root] = append(groups[root], i)
	}

	result := make([]byte, n)
	for _, indices := range groups {
		chars := make([]byte, 0)
		for _, index := range indices {
			chars = append(chars, s[index])
		}
		sortBytes(chars)
		sortInts(indices)

		for i := 0; i < len(indices); i++ {
			result[indices[i]] = chars[i]
		}
	}

	return string(result)
}

func sortBytes(s []byte) {
	for i := 0; i < len(s); i++ {
		for j := i + 1; j < len(s); j++ {
			if s[i] > s[j] {
				s[i], s[j] = s[j], s[i]
			}
		}
	}
}

func sortInts(s []int) {
	for i := 0; i < len(s); i++ {
		for j := i + 1; j < len(s); j++ {
			if s[i] > s[j] {
				s[i], s[j] = s[j], s[i]
			}
		}
	}
}