func componentValue(nums []int, edges [][]int) int {
	n := len(nums)
	sum := 0
	for _, num := range nums {
		sum += num
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	var dfs func(node, parent int, target int) int
	dfs = func(node, parent int, target int) int {
		currSum := nums[node]
		for _, neighbor := range adj[node] {
			if neighbor != parent {
				currSum += dfs(neighbor, node, target)
			}
		}
		if currSum > target {
			return -1
		}
		if currSum == target {
			return 0
		}
		return currSum
	}

	isValid := func(k int) bool {
		target := sum / k
		if sum%k != 0 {
			return false
		}
		return dfs(0, -1, target) == 0
	}

	for k := n; k >= 1; k-- {
		if sum%k == 0 && isValid(k) {
			return k - 1
		}
	}
	return 0
}