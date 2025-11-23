func loudAndRich(richer [][]int, quiet []int) []int {
	n := len(quiet)
	graph := make([][]int, n)
	inDegree := make([]int, n)
	for _, edge := range richer {
		u, v := edge[1], edge[0]
		graph[u] = append(graph[u], v)
		inDegree[v]++
	}

	ans := make([]int, n)
	for i := 0; i < n; i++ {
		ans[i] = i
	}

	q := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			q = append(q, i)
		}
	}

	for len(q) > 0 {
		u := q[0]
		q = q[1:]

		for _, v := range graph[u] {
			if quiet[ans[u]] < quiet[ans[v]] {
				ans[v] = ans[u]
			}
			inDegree[v]--
			if inDegree[v] == 0 {
				q = append(q, v)
			}
		}
	}

	return ans
}