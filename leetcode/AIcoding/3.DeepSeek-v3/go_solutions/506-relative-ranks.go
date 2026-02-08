import (
	"sort"
	"strconv"
)

func findRelativeRanks(score []int) []string {
	n := len(score)
	indices := make([][2]int, n)
	for i := 0; i < n; i++ {
		indices[i] = [2]int{score[i], i}
	}

	sort.Slice(indices, func(i, j int) bool {
		return indices[i][0] > indices[j][0]
	})

	res := make([]string, n)
	for rank, idx := range indices {
		originalIndex := idx[1]
		switch rank {
		case 0:
			res[originalIndex] = "Gold Medal"
		case 1:
			res[originalIndex] = "Silver Medal"
		case 2:
			res[originalIndex] = "Bronze Medal"
		default:
			res[originalIndex] = strconv.Itoa(rank + 1)
		}
	}

	return res
}