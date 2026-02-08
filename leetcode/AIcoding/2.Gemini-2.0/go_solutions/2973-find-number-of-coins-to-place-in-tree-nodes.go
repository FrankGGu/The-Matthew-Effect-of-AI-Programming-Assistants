import "sort"

func distributeCoins(n int, adj [][]int, coins []int) []int {
	ans := make([]int, n)
	subtreeSize := make([]int, n)
	subtreeCoins := make([]int, n)

	var dfs func(node, parent int)
	dfs = func(node, parent int) {
		subtreeSize[node] = 1
		subtreeCoins[node] = coins[node]

		children := []int{}
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				children = append(children, neighbor)
				dfs(neighbor, node)
				subtreeSize[node] += subtreeSize[neighbor]
				subtreeCoins[node] += subtreeCoins[neighbor]
			}
		}

		cost := make([]int, len(children))
		for i, child := range children {
			cost[i] = subtreeSize[child]
		}

		sort.Ints(cost)

		need := coins[node]
		for i := len(children) - 1; i >= 0; i-- {
			if need > 0 {
				move := min(need, subtreeCoins[children[i]] - cost[i])
				ans[node] += move
				need -= move
			}
		}

		give := subtreeCoins[node] - need
		for i := 0; i < len(children); i++ {
			if give > 0 {
				move := min(give, cost[i])
				ans[node] += move
				give -= move
			}
		}
	}

	dfs(0, -1)
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}