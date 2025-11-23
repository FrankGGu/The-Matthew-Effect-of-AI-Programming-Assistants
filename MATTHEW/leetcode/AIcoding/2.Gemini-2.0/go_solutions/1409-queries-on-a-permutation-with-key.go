func processQueries(queries []int, m int) []int {
	P := make([]int, m)
	for i := 0; i < m; i++ {
		P[i] = i + 1
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		index := -1
		for j, val := range P {
			if val == query {
				index = j
				break
			}
		}
		result[i] = index

		temp := P[index]
		for j := index; j > 0; j-- {
			P[j] = P[j-1]
		}
		P[0] = temp
	}

	return result
}