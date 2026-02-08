func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
	children := make([][]int, n)
	for i := 0; i < n; i++ {
		if manager[i] != -1 {
			children[manager[i]] = append(children[manager[i]], i)
		}
	}

	return dfs(headID, 0, children, informTime)
}

func dfs(u int, currentPathTime int, children [][]int, informTime []int) int {
	maxTime := currentPathTime
	for _, v := range children[u] {
		maxTime = max(maxTime, dfs(v, currentPathTime+informTime[u], children, informTime))
	}
	return maxTime
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}