import (
	"sort"
)

func reconstructQueue(people [][]int) [][]int {
	sort.Slice(people, func(i, j int) bool {
		if people[i][0] != people[j][0] {
			return people[i][0] > people[j][0]
		}
		return people[i][1] < people[j][1]
	})

	result := make([][]int, 0, len(people))
	for _, person := range people {
		k := person[1]
		if k >= len(result) {
			result = append(result, person)
		} else {
			result = append(result[:k], append([][]int{person}, result[k:]...)...)
		}
	}

	return result
}