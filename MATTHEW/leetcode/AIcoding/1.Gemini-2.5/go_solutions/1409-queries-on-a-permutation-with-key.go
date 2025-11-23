func processQueries(queries []int, m int) []int {
	p := make([]int, m)
	for i := 0; i < m; i++ {
		p[i] = i + 1
	}

	results := make([]int, len(queries))

	for i, queryVal := range queries {
		idx := -1
		for j := 0; j < len(p); j++ {
			if p[j] == queryVal {
				idx = j
				break
			}
		}

		results[i] = idx

		valToMove := p[idx]
		p = append(p[:idx], p[idx+1:]...)
		p = append([]int{valToMove}, p...)
	}

	return results
}