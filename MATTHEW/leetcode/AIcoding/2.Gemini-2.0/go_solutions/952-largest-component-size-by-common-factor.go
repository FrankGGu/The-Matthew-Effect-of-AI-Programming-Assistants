func largestComponentSize(nums []int) int {
	n := len(nums)
	parent := make([]int, n)
	size := make([]int, n)
	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
	}

	var find func(int) int
	find = func(i int) int {
		if parent[i] != i {
			parent[i] = find(parent[i])
		}
		return parent[i]
	}

	union := func(i, j int) {
		rootI := find(i)
		rootJ := find(j)
		if rootI != rootJ {
			parent[rootI] = rootJ
			size[rootJ] += size[rootI]
		}
	}

	factorsMap := make(map[int][]int)
	for i, num := range nums {
		for j := 2; j*j <= num; j++ {
			if num%j == 0 {
				factorsMap[j] = append(factorsMap[j], i)
				for num%j == 0 {
					num /= j
				}
			}
		}
		if num > 1 {
			factorsMap[num] = append(factorsMap[num], i)
		}
	}

	for _, indices := range factorsMap {
		if len(indices) > 1 {
			for i := 1; i < len(indices); i++ {
				union(indices[0], indices[i])
			}
		}
	}

	maxSize := 0
	for i := 0; i < n; i++ {
		if find(i) == i {
			maxSize = max(maxSize, size[i])
		}
	}

	if maxSize == 0 && len(nums) > 0 {
		return 1
	}

	return maxSize
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}