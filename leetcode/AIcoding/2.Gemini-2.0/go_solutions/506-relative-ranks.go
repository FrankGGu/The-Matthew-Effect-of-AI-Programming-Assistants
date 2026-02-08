import (
	"sort"
	"strconv"
)

func findRelativeRanks(score []int) []string {
	n := len(score)
	ranks := make([]string, n)
	indexedScore := make([]struct {
		index int
		value int
	}, n)

	for i := 0; i < n; i++ {
		indexedScore[i] = struct {
			index int
			value int
		}{index: i, value: score[i]}
	}

	sort.Slice(indexedScore, func(i, j int) bool {
		return indexedScore[i].value > indexedScore[j].value
	})

	for i := 0; i < n; i++ {
		index := indexedScore[i].index
		if i == 0 {
			ranks[index] = "Gold Medal"
		} else if i == 1 {
			ranks[index] = "Silver Medal"
		} else if i == 2 {
			ranks[index] = "Bronze Medal"
		} else {
			ranks[index] = strconv.Itoa(i + 1)
		}
	}

	return ranks
}