func countSubTrees(n int, edges [][]int, labels string) []int {
	graph := make([][]int, n)
	for _, edge := range edges {
		graph[edge[0]] = append(graph[edge[0]], edge[1])
		graph[edge[1]] = append(graph[edge[1]], edge[0])
	}

	result := make([]int, n)
	visited := make([]bool, n)

	var dfs func(node int) [26]int
	dfs = func(node int) [26]int {
		visited[node] = true
		counts := [26]int{}
		counts[labels[node]-'a'] = 1

		for _, neighbor := range graph[node] {
			if !visited[neighbor] {
				neighborCounts := dfs(neighbor)
				for i := 0; i < 26; i++ {
					counts[i] += neighborCounts[i]
				}
			}
		}

		result[node] = counts[labels[node]-'a']
		return counts
	}

	dfs(0)
	return result
}