func smallestMissingValueSubtree(parents []int, nums []int) []int {
	n := len(parents)
	children := make([][]int, n)
	for i := 1; i < n; i++ {
		children[parents[i]] = append(children[parents[i]], i)
	}

	ans := make([]int, n)
	for i := range ans {
		ans[i] = 1
	}

	oneIndex := -1
	for i, num := range nums {
		if num == 1 {
			oneIndex = i
			break
		}
	}

	if oneIndex == -1 {
		return ans
	}

	seen := make(map[int]bool)
	missing := 1
	curr := oneIndex

	var dfs func(node int)
	dfs = func(node int) {
		seen[nums[node]] = true
		for _, child := range children[node] {
			dfs(child)
		}
	}

	for curr != -1 {
		dfs(curr)
		for seen[missing] {
			missing++
		}
		ans[curr] = missing
		curr = parents[curr]
	}

	return ans
}