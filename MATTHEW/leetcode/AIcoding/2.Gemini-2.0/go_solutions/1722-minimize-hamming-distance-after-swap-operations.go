func minHammingDistance(nums1 []int, nums2 []int, allowedSwaps [][]int) int {
	n := len(nums1)
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

	for _, swap := range allowedSwaps {
		union(swap[0], swap[1])
	}

	groups := make(map[int][]int)
	for i := range nums1 {
		root := find(i)
		groups[root] = append(groups[root], i)
	}

	ans := 0
	for _, indices := range groups {
		m := len(indices)
		vals1 := make([]int, m)
		vals2 := make([]int, m)
		for i, idx := range indices {
			vals1[i] = nums1[idx]
			vals2[i] = nums2[idx]
		}

		counts1 := make(map[int]int)
		counts2 := make(map[int]int)

		for _, val := range vals1 {
			counts1[val]++
		}
		for _, val := range vals2 {
			counts2[val]++
		}

		for val, count := range counts2 {
			if c1, ok := counts1[val]; ok {
				minCount := min(c1, count)
				counts1[val] -= minCount
				counts2[val] -= minCount
			}
		}

		for _, count := range counts2 {
			ans += count
		}
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}