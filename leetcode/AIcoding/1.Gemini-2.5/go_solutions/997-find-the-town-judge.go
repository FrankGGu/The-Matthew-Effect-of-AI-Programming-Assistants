func findJudge(n int, trust [][]int) int {
	if n == 1 {
		return 1
	}

	indegree := make([]int, n+1)
	outdegree := make([]int, n+1)

	for _, t := range trust {
		outdegree[t[0]]++
		indegree[t[1]]++
	}

	for i := 1; i <= n; i++ {
		if outdegree[i] == 0 && indegree[i] == n-1 {
			return i
		}
	}

	return -1
}