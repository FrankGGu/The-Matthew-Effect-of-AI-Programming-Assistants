func longestSpecialPath(n int, edges [][]int) int {
	graph := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		graph[v] = append(graph[v], u)
	}

	maxLen := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			q := []struct {
				node  int
				path  []int
			}{{i, []int{i}}}

			for len(q) > 0 {
				curr := q[0]
				q = q[1:]
				node := curr.node
				path := curr.path

				if node == j {
					special := true
					for k := 0; k < len(path)-1; k++ {
						if path[k] == path[k+1] {
							special = false
							break
						}
					}
					if special {
						maxLen = max(maxLen, len(path))
					}
					continue
				}

				for _, neighbor := range graph[node] {
					found := false
					for _, p := range path {
						if p == neighbor {
							found = true
							break
						}
					}
					if !found {
						newPath := make([]int, len(path))
						copy(newPath, path)
						newPath = append(newPath, neighbor)
						q = append(q, struct {
							node  int
							path  []int
						}{neighbor, newPath})
					}
				}
			}
		}
	}

	if maxLen == 0 {
		return -1
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}