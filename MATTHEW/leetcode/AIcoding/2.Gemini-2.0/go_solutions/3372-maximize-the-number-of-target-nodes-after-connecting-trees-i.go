func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func solve(adj map[int][]int, target map[int]bool, root int) (int, bool) {
	if _, ok := target[root]; !ok {
		return 0, false
	}

	children := []int{}
	for _, neighbor := range adj[root] {
		children = append(children, neighbor)
	}

	if len(children) == 0 {
		return 1, true
	}

	connected := 0
	unconnected := 0
	for _, child := range children {
		c, s := solve(adj, target, child)
		if s {
			connected += c
		} else {
			unconnected += c
		}
	}

	return max(1+unconnected, connected), true
}

func solve2(adj map[int][]int, target map[int]bool, roots []int) int {
	connected := 0
	unconnected := 0
	for _, root := range roots {
		c, s := solve(adj, target, root)
		if s {
			connected += c
		} else {
			unconnected += c
		}
	}
	return connected
}

func maxTargetNodes(edges [][]int, target []int) int {
	n := len(edges) + 1
	adj := make(map[int][]int)
	indegree := make([]int, n+1)
	targetMap := make(map[int]bool)

	for i := 0; i < len(edges); i++ {
		adj[edges[i][0]] = append(adj[edges[i][0]], edges[i][1])
		indegree[edges[i][1]]++
	}

	for i := 0; i < len(target); i++ {
		targetMap[target[i]] = true
	}

	roots := []int{}
	for i := 1; i <= n; i++ {
		if indegree[i] == 0 {
			roots = append(roots, i)
		}
	}

	return solve2(adj, targetMap, roots)
}