func longestCycle(edges []int) int {
	n := len(edges)
	visited := make([]bool, n)
	inStack := make([]bool, n)
	var longest int

	var dfs func(node int, depth int) int
	dfs = func(node int, depth int) int {
		if inStack[node] {
			return depth
		}
		if visited[node] {
			return -1
		}
		visited[node] = true
		inStack[node] = true
		next := edges[node]
		var cycleLength int
		if next != -1 {
			cycleLength = dfs(next, depth+1)
		}
		inStack[node] = false
		if cycleLength != -1 {
			return cycleLength
		}
		return -1
	}

	for i := 0; i < n; i++ {
		if !visited[i] {
			cycleLength := dfs(i, 0)
			if cycleLength > longest {
				longest = cycleLength
			}
		}
	}

	return longest
}