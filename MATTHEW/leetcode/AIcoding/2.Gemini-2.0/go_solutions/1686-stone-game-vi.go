import "sort"

func stoneGameVI(aliceValues []int, bobValues []int) int {
	n := len(aliceValues)
	diff := make([]int, n)
	for i := 0; i < n; i++ {
		diff[i] = aliceValues[i] + bobValues[i]
	}

	indices := make([]int, n)
	for i := 0; i < n; i++ {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return diff[indices[i]] > diff[indices[j]]
	})

	aliceScore := 0
	bobScore := 0

	for i := 0; i < n; i++ {
		if i%2 == 0 {
			aliceScore += aliceValues[indices[i]]
		} else {
			bobScore += bobValues[indices[i]]
		}
	}

	if aliceScore > bobScore {
		return 1
	} else if aliceScore < bobScore {
		return -1
	} else {
		return 0
	}
}