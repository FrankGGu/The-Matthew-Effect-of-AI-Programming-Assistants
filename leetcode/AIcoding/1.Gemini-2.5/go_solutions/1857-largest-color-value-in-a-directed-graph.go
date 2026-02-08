package main

import "container/list"

func largestPathValue(colors string, edges [][]int) int {
	n := len(colors)
	adj := make([][]int, n)
	inDegree := make([]int, n)

	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		inDegree[v]++
	}

	// dp[i][j] stores the maximum count of character 'a'+j in any path ending at node i.
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, 26)
	}

	queue := list.New()
	for i := 0; i < n; i++ {
		if inDegree[i] == 0 {
			queue.PushBack(i)
		}
	}

	maxColorValue := 0
	nodesVisited := 0

	for queue.Len() > 0 {
		element := queue.Front()
		queue.Remove(element)
		u := element.Value.(int)

		nodesVisited++

		// Increment count for the color of the current node u
		colorIdx := int(colors[u] - 'a')
		dp[u][colorIdx]++
		maxColorValue = max(maxColorValue, dp[u][colorIdx])

		// Propagate dp values to neighbors
		for _, v := range adj[u] {
			for c := 0; c < 26; c++ {
				dp[v][c] = max(dp[v][c], dp[u][c])
			}
			inDegree[v]--
			if inDegree[v] == 0 {
				queue.PushBack(v)
			}
		}
	}

	if nodesVisited != n {
		return -1 // Cycle detected
	}

	return maxColorValue
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}