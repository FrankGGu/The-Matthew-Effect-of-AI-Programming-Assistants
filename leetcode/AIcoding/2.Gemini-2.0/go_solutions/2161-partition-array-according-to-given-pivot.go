func pivotArray(nums []int, pivot int) []int {
	less := []int{}
	equal := []int{}
	greater := []int{}

	for _, num := range nums {
		if num < pivot {
			less = append(less, num)
		} else if num == pivot {
			equal = append(equal, num)
		} else {
			greater = append(greater, num)
		}
	}

	result := append(less, equal...)
	result = append(result, greater...)

	return result
}