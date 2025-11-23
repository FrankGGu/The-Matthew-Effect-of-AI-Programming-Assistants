import "sort"

func largestValsFromLabels(values []int, labels []int, numWanted int, useLimit int) int {
	n := len(values)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return values[indices[i]] > values[indices[j]]
	})

	labelCount := make(map[int]int)
	sum := 0
	count := 0

	for _, i := range indices {
		label := labels[i]
		if labelCount[label] < useLimit {
			sum += values[i]
			labelCount[label]++
			count++
			if count == numWanted {
				break
			}
		}
	}

	return sum
}