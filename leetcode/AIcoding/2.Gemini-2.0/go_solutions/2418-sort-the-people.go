import "sort"

func sortPeople(names []string, heights []int) []string {
	n := len(names)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return heights[indices[i]] > heights[indices[j]]
	})

	result := make([]string, n)
	for i := range result {
		result[i] = names[indices[i]]
	}

	return result
}