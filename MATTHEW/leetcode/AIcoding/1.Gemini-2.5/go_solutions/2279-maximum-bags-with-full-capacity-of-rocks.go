func maximumBags(capacity []int, rocks []int, additionalRocks int) int {
	n := len(capacity)
	diffs := make([]int, n)

	for i := 0; i < n; i++ {
		diffs[i] = capacity[i] - rocks[i]
	}

	sort.Ints(diffs)

	fullBags := 0
	for _, diff := range diffs {
		if diff == 0 {
			fullBags++
			continue
		}
		if additionalRocks >= diff {
			additionalRocks -= diff
			fullBags++
		} else {
			break
		}
	}

	return fullBags
}