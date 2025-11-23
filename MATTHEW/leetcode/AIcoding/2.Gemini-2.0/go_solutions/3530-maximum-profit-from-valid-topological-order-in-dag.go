func maxProfit(cost []int, roads [][]int) int64 {
	n := len(cost)
	graph := make([][]int, n)
	inDegree := make([]int, n)
	for _, road := range roads {
		graph[road[0]] = append(graph[road[0]], road[1])
		inDegree[road[1]]++
	}

	queue := []int{}
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
	}

	result := int64(0)
	count := 0
	dp := make([]int, n)
	for i := 0; i < n; i++ {
		dp[i] = cost[i]
	}

	for len(queue) > 0 {
		node := queue[0]
		queue = queue[1:]
		result += int64(dp[node])
		count++

		for _, neighbor := range graph[node] {
			dp[neighbor] = max(dp[neighbor], dp[node])
			inDegree[neighbor]--
			if inDegree[neighbor] == 0 {
				queue = append(queue, neighbor)
			}
		}
	}

	if count != n {
		return -1
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}