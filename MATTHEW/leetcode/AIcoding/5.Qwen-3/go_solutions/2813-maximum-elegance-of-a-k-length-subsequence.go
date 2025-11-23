package main

func maximumElegance(weights []int, labels []int, k int) int {
	type Pair struct {
		weight int
		label  int
	}
	pairs := make([]Pair, len(weights))
	for i := range weights {
		pairs[i] = Pair{weights[i], labels[i]}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].weight > pairs[j].weight
	})

	labelMap := make(map[int]int)
	selected := make([]int, 0, k)
	for i := 0; i < k; i++ {
		labelMap[pairs[i].label]++
		selected = append(selected, pairs[i].weight)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(selected)))

	uniqueCount := 0
	for _, v := range labelMap {
		if v == 1 {
			uniqueCount++
		}
	}

	result := 0
	for i := 0; i < len(selected); i++ {
		result += selected[i]
	}

	for i := k; i < len(pairs); i++ {
		if labelMap[pairs[i].label] == 0 {
			if uniqueCount < len(labelMap) {
				labelMap[pairs[i].label]++
				selected = append(selected, pairs[i].weight)
				sort.Sort(sort.Reverse(sort.IntSlice(selected)))
				result += pairs[i].weight
				uniqueCount++
			}
		} else {
			if len(selected) > 0 && selected[len(selected)-1] < pairs[i].weight {
				result += pairs[i].weight - selected[len(selected)-1]
				selected[len(selected)-1] = pairs[i].weight
				sort.Sort(sort.Reverse(sort.IntSlice(selected)))
			}
		}
	}

	return result
}