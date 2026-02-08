func groupThePeople(groupSizes []int) [][]int {
	groupsByLen := make(map[int][]int)
	for i, size := range groupSizes {
		groupsByLen[size] = append(groupsByLen[size], i)
	}

	result := [][]int{}
	for size, people := range groupsByLen {
		for i := 0; i < len(people); i += size {
			group := people[i : i+size]
			result = append(result, group)
		}
	}

	return result
}