func validArrangement(pairs [][]int) [][]int {
	graph := make(map[int][]int)
	inDegree := make(map[int]int)
	outDegree := make(map[int]int)

	for _, pair := range pairs {
		u, v := pair[0], pair[1]
		graph[u] = append(graph[u], v)
		outDegree[u]++
		inDegree[v]++
	}

	startNode := pairs[0][0]
	found := false
	for node := range outDegree {
		if outDegree[node]-inDegree[node] == 1 {
			startNode = node
			found = true
			break
		}
	}
	if !found {
		for node := range graph {
			startNode = node
			break
		}
	}

	result := [][]int{}
	var dfs func(u int)
	dfs = func(u int) {
		for len(graph[u]) > 0 {
			v := graph[u][len(graph[u])-1]
			graph[u] = graph[u][:len(graph[u])-1]
			dfs(v)
			result = append(result, []int{u, v})
		}
	}

	dfs(startNode)

	for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
		result[i], result[j] = result[j], result[i]
	}

	return result
}