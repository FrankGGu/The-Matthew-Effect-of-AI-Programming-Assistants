func gcd(a, b int) int {
	if b == 0 {
		return a
	}
	return gcd(b, a%b)
}

func treeOfCoprimes(nums []int, edges [][]int) []int {
	n := len(nums)
	adj := make([][]int, n)
	for _, edge := range edges {
		adj[edge[0]] = append(adj[edge[0]], edge[1])
		adj[edge[1]] = append(adj[edge[1]], edge[0])
	}

	ans := make([]int, n)
	for i := range ans {
		ans[i] = -1
	}

	var dfs func(node, parent int, path []int, pathNums []int)
	dfs = func(node, parent int, path []int, pathNums []int) {
		for i := len(pathNums) - 1; i >= 0; i-- {
			if gcd(nums[node], pathNums[i]) == 1 {
				ans[node] = path[i]
				break
			}
		}

		for _, neighbor := range adj[node] {
			if neighbor != parent {
				dfs(neighbor, node, append(path, node), append(pathNums, nums[node]))
			}
		}
	}

	dfs(0, -1, []int{}, []int{})
	return ans
}