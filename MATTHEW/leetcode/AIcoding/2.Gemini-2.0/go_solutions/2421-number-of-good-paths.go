func numberOfGoodPaths(vals []int, edges [][]int) int {
	n := len(vals)
	parent := make([]int, n)
	size := make([]int, n)
	nodeMap := make(map[int][]int)

	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
		if _, ok := nodeMap[vals[i]]; !ok {
			nodeMap[vals[i]] = []int{}
		}
		nodeMap[vals[i]] = append(nodeMap[vals[i]], i)
	}

	find := func(x int) int {
		if parent[x] == x {
			return x
		}
		parent[x] = find(parent[x])
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			parent[rootX] = rootY
			size[rootY] += size[rootX]
		}
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	keys := make([]int, 0, len(nodeMap))
	for k := range nodeMap {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	ans := 0
	for _, val := range keys {
		nodes := nodeMap[val]
		for _, node := range nodes {
			for _, neighbor := range adj[node] {
				if vals[neighbor] <= val {
					union(node, neighbor)
				}
			}
		}

		groupCount := make(map[int]int)
		for _, node := range nodes {
			root := find(node)
			groupCount[root]++
		}

		for _, count := range groupCount {
			ans += count * (count + 1) / 2
		}
	}

	return ans
}