import "sort"

func maximizeTheNumberOfTargetNodes(edges [][]int, target int) int {
	n := len(edges) + 1
	graph := make([][]int, n)
	inDegree := make([]int, n)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		inDegree[v]++
	}

	var dfs func(node int) (int, int)
	dfs = func(node int) (int, int) {
		if node == target {
			return 1, 0
		}
		if len(graph[node]) == 0 {
			return 0, 0
		}

		targetNodes := 0
		nonTargetNodes := 0
		diffs := []int{}

		for _, neighbor := range graph[node] {
			t, nt := dfs(neighbor)
			targetNodes += t
			nonTargetNodes += nt
			diffs = append(diffs, t-nt)
		}

		sort.Sort(sort.Reverse(sort.IntSlice(diffs)))

		if len(diffs) > 0 && diffs[0] > 0 {
			targetNodes++
			nonTargetNodes += (len(graph[node]) - 1)
		} else {
			nonTargetNodes += len(graph[node])
		}

		return targetNodes, nonTargetNodes
	}

	ans := 0
	roots := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			roots = append(roots, i)
		}
	}

	for _, root := range roots {
		t, _ := dfs(root)
		ans += t
	}

	return ans
}