import "sort"

func minimumBoxes(apple []int, capacity []int) int {
	totalApples := 0
	for _, a := range apple {
		totalApples += a
	}

	sort.Slice(capacity, func(i, j int) bool {
		return capacity[i] > capacity[j]
	})

	boxesUsed := 0
	currentCapacitySum := 0
	for _, c := range capacity {
		currentCapacitySum += c
		boxesUsed++
		if currentCapacitySum >= totalApples {
			return boxesUsed
		}
	}
	return boxesUsed
}