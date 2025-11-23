func findOccurrences(arr []int, x int, queries []int) []int {
	occurrences := []int{}
	for i, num := range arr {
		if num == x {
			occurrences = append(occurrences, i)
		}
	}

	results := make([]int, len(queries))
	for i, q := range queries {
		if q > 0 && q <= len(occurrences) {
			results[i] = occurrences[q-1]
		} else {
			results[i] = -1
		}
	}

	return results
}