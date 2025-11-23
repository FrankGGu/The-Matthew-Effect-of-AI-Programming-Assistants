package main

func frogPosition(n int, edges [][]int, t int, target int) int {
	adj := make([][]int, n+1)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	visited := make([]bool, n+1)
	var dfs func(int, int, int) int
	dfs = func(node, time, parent int) int {
		if time == t {
			if node == target {
				return node
			}
			return -1
		}

		children := 0
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				children++
			}
		}

		if children == 0 {
			if node == target {
				return node
			}
			return -1
		}

		for _, neighbor := range adj[node] {
			if neighbor != parent {
				result := dfs(neighbor, time+1, node)
				if result != -1 {
					return result
				}
			}
		}

		return -1
	}

	return dfs(1, 0, -1)
}