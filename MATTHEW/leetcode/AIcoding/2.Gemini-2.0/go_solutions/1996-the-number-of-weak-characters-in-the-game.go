import "sort"

func numberOfWeakCharacters(properties [][]int) int {
	sort.Slice(properties, func(i, j int) bool {
		if properties[i][0] == properties[j][0] {
			return properties[i][1] > properties[j][1]
		}
		return properties[i][0] < properties[j][0]
	})

	weakCharacters := 0
	maxDefense := 0
	for i := len(properties) - 1; i >= 0; i-- {
		if properties[i][1] < maxDefense {
			weakCharacters++
		}
		if properties[i][1] > maxDefense {
			maxDefense = properties[i][1]
		}
	}

	return weakCharacters
}