import "sort"

func findLongestChain(pairs [][]int) int {
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][1] < pairs[j][1]
	})

	count := 0
	currEnd := -1001

	for _, pair := range pairs {
		if pair[0] > currEnd {
			count++
			currEnd = pair[1]
		}
	}

	return count
}