func checkWays(pairs [][]int) int {
	adj := make(map[int]map[int]struct{})
	nodes := make(map[int]struct{})

	for _, pair := range pairs {
		u, v := pair[0], pair[1]
		if