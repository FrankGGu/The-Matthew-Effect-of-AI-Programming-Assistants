func buildMatrix(k int, rowConditions [][]int, colConditions [][]int) [][]int {
	rowOrder := topologicalSort(k, rowConditions)
	if rowOrder == nil {
		return [][]int{}
	}

	colOrder := topologicalSort(k, colConditions)
	if colOrder == nil {
		return [][]int{}
	}

	rowPos := make([]int, k+1)
	colPos := make([]int, k+1)

	for i := 0; i < k; i++ {
		rowPos[rowOrder[i]] = i
		colPos[colOrder[i]] = i
	}

	matrix := make([][]int, k)
	for i := range matrix {
		matrix[i] = make([]int, k)
	}

	for i := 1; i <= k; i++ {
		matrix[rowPos[i]][colPos[i]] = i
	}

	return matrix
}

func topologicalSort(k int, conditions [][]int) []int {
	adj := make([][]int, k+1)
	inDegree := make([]int, k+1)

	for _, cond := range conditions {
		u, v := cond[0], cond[1]
		adj[u] = append(adj[u], v)
		inDegree[v]++
	}

	queue := []int{}
	for i := 1; i <= k; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	order := []int{}
	for len(queue) > 0 {
		u := queue[0]
		queue = queue[1:]
		order = append(order, u)

		for _, v := range adj[u] {
			inDegree[v]--
			if inDegree[v] == 0 {
				queue = append(queue, v)
			}
		}
	}

	if len(order) == k {
		return order
	}
	return nil
}