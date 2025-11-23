func findMinHeightTrees(n int, edges [][]int) []int {
	if n == 1 {
		return []int{0}
	}

	adj := make([][]int, n)
	degree := make([]int, n)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
		degree[u]++
		degree[v]++
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if degree[i] == 1 {
			queue = append(queue, i)
		}
	}

	remainingNodes := n
	for remainingNodes > 2 {
		numLeavesInCurrentLayer := len(queue)
		remainingNodes -= numLeavesInCurrentLayer

		for i := 0; i < numLeavesInCurrentLayer; i++ {
			u := queue[0]
			queue = queue[1:]

			for _, v := range adj[u] {
				degree[v]--
				if degree[v] == 1 {
					queue = append(queue, v)
				}
			}
		}
	}

	return queue
}