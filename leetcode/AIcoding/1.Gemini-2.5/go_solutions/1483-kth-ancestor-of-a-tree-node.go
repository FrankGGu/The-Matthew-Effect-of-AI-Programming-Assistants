package main

type TreeAncestor struct {
	dp     [][]int
	maxLog int
	n      int
}

func Constructor(n int, parent []int) TreeAncestor {
	maxLog := 0
	for (1 << maxLog) <= n {
		maxLog++
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, maxLog)
		for j := range dp[i] {
			dp[i][j] = -1 
		}
	}

	for i := 0; i < n; i++ {
		dp[i][0] = parent[i]
	}

	for j := 1; j < maxLog; j++ {
		for i := 0; i < n; i++ {
			if dp[i][j-1] != -1 {
				dp[i][j] = dp[dp[i][j-1]][j-1]
			}
		}
	}

	return TreeAncestor{
		dp:     dp,
		maxLog: maxLog,
		n:      n,
	}
}

func (this *TreeAncestor) GetKthAncestor(node int, k int) int {
	for j := this.maxLog - 1; j >= 0; j-- {
		if (k>>j)&1 == 1 {
			if node == -1 {
				return -1
			}
			node = this.dp[node][j]
		}
	}
	return node
}