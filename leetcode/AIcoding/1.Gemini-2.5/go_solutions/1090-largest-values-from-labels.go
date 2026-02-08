type Item struct {
	value int
	label int
}

func largestValsFromLabels(values []int, labels []int, numWanted int, useLimit int) int {
	n := len(values)
	items := make([]Item, n)

	// Combine values and labels into Item structs
	for i := 0; i < n; i++ {
		items[i] = Item{value: values[i], label: labels[i]}
	}

	// Sort items in descending order based on their values
	sort.Slice(items, func(i, j int) bool {
		return items[i].value > items[j].value
	})

	totalSum := 0
	pickedCount := 0
	labelCounts := make(map[int]int) // To keep track of how many items picked for each label

	// Iterate through sorted items and pick greedily
	for _, item := range items {
		// If we have already picked numWanted items, stop
		if pickedCount == numWanted {
			break
		}

		// Check if picking this item's label would exceed useLimit
		if labelCounts[item.label] < useLimit {
			totalSum += item.value
			labelCounts[item.label]++ // Increment count for this label
			pickedCount++             // Increment total picked count
		}
	}

	return totalSum
}