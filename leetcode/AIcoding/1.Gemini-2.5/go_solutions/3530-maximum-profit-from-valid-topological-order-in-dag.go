package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumProfit(n int, profits []int, edges [][]int) int {
	graph := make([][]int, n)
	inDegree := make([]int, n)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		graph[u] = append(graph[u], v)
		inDegree[v]++
	}

	dp := make([]int, n)
	queue := []int{} // Using a slice as a queue

	maxOverallProfit := 0

	for i := 0; i < n; i++ {
		dp[i] = profits[i] // Initialize dp[i] with the profit of node i itself
		if inDegree[i] == 0 {
			queue = append(queue, i)
		}
		maxOverallProfit = max(maxOverallProfit, dp[i]) // A single node can be the max profit path
	}

	for len(queue) > 0 {
		u := queue[0]
		queue = queue[1:] // Dequeue

		for _, v := range graph[u] {
			// Update dp[v]: max profit ending at v is either its current value
			// or the profit of v plus the max profit ending at u
			dp[v] = max(dp[v], dp[u]+profits[v])
			maxOverallProfit = max(maxOverallProfit, dp[v]) // Update overall max profit

			inDegree[v]--
			if inDegree[v] == 0 {
				queue = append(queue, v) // Enqueue if all predecessors processed
			}
		}
	}

	return maxOverallProfit
}