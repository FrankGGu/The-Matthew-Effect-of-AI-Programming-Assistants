import "sort"

func relativeSortArray(arr1 []int, arr2 []int) []int {
	count := make(map[int]int)
	for _, num := range arr1 {
		count[num]++
	}

	result := []int{}
	for _, num := range arr2 {
		for i := 0; i < count[num]; i++ {
			result = append(result, num)
		}
		delete(count, num)
	}

	remaining := []int{}
	for num, freq := range count {
		for i := 0; i < freq; i++ {
			remaining = append(remaining, num)
		}
	}

	sort.Ints(remaining)
	result = append(result, remaining...)

	return result
}