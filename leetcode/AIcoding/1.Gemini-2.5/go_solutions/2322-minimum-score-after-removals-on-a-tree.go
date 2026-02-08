func minimumScore(nums []int, edges [][]int) int {
	n := len(nums)
	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]
		adj