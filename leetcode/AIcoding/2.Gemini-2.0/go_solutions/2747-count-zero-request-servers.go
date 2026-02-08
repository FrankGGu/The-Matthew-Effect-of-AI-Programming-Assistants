func countServers(n int, logs [][]int, x int, queries []int) []int {
	result := make([]int, len(queries))
	for i, q := range queries {
		count := 0
		for j := 1; j <= n; j++ {
			valid := false
			for _, log := range logs {
				if log[0] == j && q-x <= log[1] && log[1] <= q {
					valid = true
					break
				}
			}
			if valid {
				count++
			}
		}
		result[i] = count
	}
	return result
}