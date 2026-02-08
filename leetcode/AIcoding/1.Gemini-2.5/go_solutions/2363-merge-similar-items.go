func mergeSimilarItems(items1 [][]int, items2 [][]int) [][]int {
	itemMap := make(map[int]int)

	for _, item := range items1 {
		value := item[0]
		weight := item[1]
		itemMap[value] += weight
	}

	for _, item := range items2 {
		value := item[0]
		weight := item[1]
		itemMap[value] += weight
	}

	result := make([][]int, 0, len(itemMap))
	for value, weight := range itemMap {
		result = append(result, []int{value, weight})
	}

	sort.Slice(result, func(i, j int) bool {
		return result[i][0] < result[j][0]
	})

	return result
}