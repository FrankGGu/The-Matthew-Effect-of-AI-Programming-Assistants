func countSubtrees(n int, edges [][]int) []int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0]-1, edge[1]-1
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	ans := make([]int, n-1)
	for i := 1; i < (1 << n); i++ {
		nodes := []int{}
		for j := 0; j < n; j++ {
			if (i>>j)&1 == 1 {
				nodes = append(nodes, j)
			}
		}

		if !isConnected(nodes, adj) {
			continue
		}

		maxDist := 0
		for _, start := range nodes {
			for _, end := range nodes {
				dist := bfs(start, end, nodes, adj)
				if dist > maxDist {
					maxDist = dist
				}
			}
		}

		if maxDist > 0 {
			ans[maxDist-1]++
		}
	}

	return ans
}

func isConnected(nodes []int, adj [][]int) bool {
	if len(nodes) == 0 {
		return false
	}

	start := nodes[0]
	visited := make(map[int]bool)
	queue := []int{start}
	visited[start] = true
	count := 0

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]
		count++

		for _, neighbor := range adj[curr] {
			found := false
			for _, node := range nodes {
				if node == neighbor {
					found = true
					break
				}
			}
			if found && !visited[neighbor] {
				visited[neighbor] = true
				queue = append(queue, neighbor)
			}
		}
	}

	return count == len(nodes)
}

func bfs(start int, end int, nodes []int, adj [][]int) int {
	if start == end {
		return 0
	}

	queue := []struct {
		node int
		dist int
	}{{start, 0}}
	visited := make(map[int]bool)
	visited[start] = true

	for len(queue) > 0 {
		curr := queue[0]
		queue = queue[1:]

		if curr.node == end {
			return curr.dist
		}

		for _, neighbor := range adj[curr.node] {
			found := false
			for _, node := range nodes {
				if node == neighbor {
					found = true
					break
				}
			}
			if found && !visited[neighbor] {
				visited[neighbor] = true
				queue = append(queue, struct {
					node int
					dist int
				}{neighbor, curr.dist + 1})
			}
		}
	}

	return 0
}