import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func minCost(stones []int) int {
	n := len(stones)
	ans := 0
	for i := 1; i < n; i++ {
		ans = max(ans, stones[i]-stones[i-1])
	}
	for i := 0; i < n-1; i++ {
		ans = max(ans, stones[i+1]-stones[i])
	}
	return ans
}