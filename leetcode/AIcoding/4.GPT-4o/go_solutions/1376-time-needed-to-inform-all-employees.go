func numOfMinutes(n int, headID int, manager []int, informTime []int) int {
	graph := make([][]int, n)
	for i, m := range manager {
		if m != -1 {
			graph[m] = append(graph[m], i)
		}
	}
	var dfs func(int) int
	dfs = func(id int) int {
		time := 0
		for _, subordinate := range graph[id] {
			time = max(time, dfs(subordinate))
		}
		return time + informTime[id]
	}
	return dfs(headID)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}