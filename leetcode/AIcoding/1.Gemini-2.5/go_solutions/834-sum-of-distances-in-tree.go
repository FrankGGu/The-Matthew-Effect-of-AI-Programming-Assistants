func sumOfDistancesInTree(n int, edges [][]int) []int {
	if n == 1 {
		return []int{0}
	}

	adj := make([][]int, n)
	for _, edge := range edges {
		u, v := edge[0], edge[1]