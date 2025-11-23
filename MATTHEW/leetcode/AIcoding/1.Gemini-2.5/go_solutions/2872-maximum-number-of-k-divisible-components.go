func maxKDivisibleComponents(n int, edges [][]int, values []int, k int) int {
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj