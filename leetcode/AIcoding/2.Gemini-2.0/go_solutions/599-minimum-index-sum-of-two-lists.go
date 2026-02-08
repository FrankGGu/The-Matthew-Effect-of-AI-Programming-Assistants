func findRestaurant(list1 []string, list2 []string) []string {
	m := make(map[string]int)
	for i, s := range list1 {
		m[s] = i
	}
	minSum := 2001
	var result []string
	for i, s := range list2 {
		if j, ok := m[s]; ok {
			sum := i + j
			if sum < minSum {
				minSum = sum
				result = []string{s}
			} else if sum == minSum {
				result = append(result, s)
			}
		}
	}
	return result
}