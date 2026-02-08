func processRestrictedFriendRequests(n int, requests [][]int, restrictions [][]int) []bool {
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

	union := func(x, y int) bool {
		rootX := find(x)
		rootY := find(y)
		if rootX == rootY {
			return false
		}
		parent[rootX] = rootY
		return true
	}

	result := make([]bool, len(requests))
	for i, req := range requests {
		u, v := req[0], req[1]
		rootU := find(u)
		rootV := find(v)

		valid := true
		for _, res := range restrictions {
			x, y := res[0], res[1]
			rootX := find(x)
			rootY := find(y)

			if (rootU == rootX && rootV == rootY) || (rootU == rootY && rootV == rootX) {
				valid = false
				break
			}
		}

		if valid {
			result[i] = union(u, v)
		} else {
			result[i] = false
		}
	}

	return result
}