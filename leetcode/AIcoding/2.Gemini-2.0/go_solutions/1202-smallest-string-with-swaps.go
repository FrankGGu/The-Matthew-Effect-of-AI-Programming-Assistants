import (
	"sort"
)

func smallestStringWithSwaps(s string, pairs [][]int) string {
	n := len(s)
	parent := make([]int, n)
	for i := range parent {
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
		chars := make([]byte, len(indices))
		for i, index := range indices {
			chars[i] = s[index]
		}
		sort.Slice(chars, func(i, j int) bool {
			return chars[i] < chars[j]
		})
		sort.Ints(indices)
		for i, index := range indices {
			result[index] = chars[i]
		}
	}

	return string(result)
}