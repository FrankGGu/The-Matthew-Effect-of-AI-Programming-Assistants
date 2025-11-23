package main

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

var adj [][]int
var coinValues []int
var K int
var memo [][]int64 // memo[u][remaining_k]

func solve(u, p, remainingK int) int64 {
	if memo[u][remainingK] != -1 {
		return memo[u][remainingK]
	}

	// Option 1: Don't halve coins[u]
	res1 := int64(coinValues[u])
	for _, v := range adj[u] {
		if v == p {
			continue
		}
		res1 += solve(v, u, remainingK)
	}

	// Option 2: Halve coins[u] (if remainingK > 0)
	var res2 int64 = -1 // Sentinel value, will only be used if remainingK > 0
	if remainingK > 0 {
		res2 = int64(coinValues[u] / 2)
		for _, v := range adj[u] {
			if v == p {
				continue
			}
			res2 += solve(v, u, remainingK-1)
		}
	}

	ans := res1
	if remainingK > 0 {
		ans = max(res1, res2)
	}

	memo[u][remainingK] = ans
	return ans
}

func maximumPoints(edges [][]int, coins []int, k int) int64 {
	n := len(coins)
	adj = make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj[u] = append(adj[u], v)
		adj[v] = append(adj[v], u)
	}

	coinValues = coins
	K = k

	memo = make([][]int64, n)
	for i := range memo {
		memo[i] = make([]int64, K+1)
		for j := range memo[i] {
			memo[i][j] = -1
		}
	}

	return solve(0, -1, K)
}