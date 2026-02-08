func subsets(nums []int) [][]int {
	result := [][]int{{}}
	for _, num := range nums {
		length := len(result)
		for i := 0; i < length; i++ {
			subset := make([]int, len(result[i]))
			copy(subset, result[i])
			subset = append(subset, num)
			result = append(result, subset)
		}
	}
	return result
}