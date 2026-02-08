func groupStrings(words []string) int {
	parent := make([]int, len(words))
	size := make([]int, len(words))
	for i := range words {
		parent[i] = i
		size[i] = 1
	}

	find := func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			if size[rootX] < size[rootY] {
				rootX, rootY = rootY, rootX
			}
			parent[rootY] = rootX
			size[rootX] += size[rootY]
		}
	}

	masks := make([]int, len(words))
	for i, word := range words {
		for _, ch := range word {
			masks[i] |= 1 << (ch - 'a')
		}
	}

	for i := 0; i < len(words); i++ {
		for j := i + 1; j < len(words); j++ {
			if hammingDistance(masks[i], masks[j]) <= 2 {
				union(i, j)
			}
		}
	}

	groups := 0
	maxSize := 0
	roots := make(map[int]bool)
	for i := range words {
		root := find(i)
		if !roots[root] {
			groups++
			roots[root] = true
			maxSize = max(maxSize, size[root])
		}
	}

	return groups
}

func hammingDistance(x, y int) int {
	xor := x ^ y
	distance := 0
	for xor > 0 {
		distance += xor & 1
		xor >>= 1
	}
	return distance
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}