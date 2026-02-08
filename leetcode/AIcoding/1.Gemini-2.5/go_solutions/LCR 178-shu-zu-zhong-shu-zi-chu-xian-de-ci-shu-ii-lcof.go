package main

func numWays(n int, relation [][]int, k int) int {
	adj := make([][]int, n)
	for _, r := range relation {
		src, dst := r[0], r[1]
		adj[src] = append(adj[src], dst)
	}

	dp := make([]int, n)
	dp[0] = 1

	for step := 0; step < k; step++ {
		nextDp := make([]int, n)
		for i := 0; i < n; i++ {
			if dp[i] > 0 {
				for _, neighbor := range adj[i] {
					nextDp[neighbor] += dp[i]
				}
			}
		}
		dp = nextDp
	}

	return dp[n-1]
}