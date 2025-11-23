package main

func subarrayBitwiseORs(arr []int) int {
	result := make(map[int]struct{})
	prevORs := make(map[int]struct{})

	for _, num := range arr {
		currentORs := make(map[int]struct{})
		currentORs[num] = struct{}{}

		for prevVal := range prevORs {
			currentORs[prevVal|num] = struct{}{}
		}

		for val := range currentORs {
			result[val] = struct{}{}
		}
		prevORs = currentORs
	}

	return len(result)
}