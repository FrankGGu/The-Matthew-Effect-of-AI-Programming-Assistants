func cycleLengthQueries(n int, queries [][]int) []int {
	ans := make([]int, len(queries))
	for i, query := range queries {
		node1, node2 := query[0], query[1]
		length := 1
		for node1 != node2 {
			if node1 > node2 {
				node1 /= 2
			} else {
				node2 /= 2
			}
			length++
		}
		ans[i] = length
	}
	return ans
}