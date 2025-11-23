import "sort"

func reconstructQueue(people [][]int) [][]int {
	sort.Slice(people, func(i, j int) bool {
		if people[i][0] == people[j][0] {
			return people[i][1] < people[j][1]
		}
		return people[i][0] > people[j][0]
	})

	result := make([][]int, 0)
	for _, p := range people {
		index := p[1]
		result = append(result[:index], append([][]int{p}, result[index:]...)...)
	}

	return result
}