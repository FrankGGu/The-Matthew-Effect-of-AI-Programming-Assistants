func findMatrix(nums []int) [][]int {
	counts := make(map[int]int)
	result := [][]int{}

	for _, num := range nums {
		row := counts[num]
		if len(result) <= row {
			result = append(result, []int{})
		}
		result[row] = append(result[row], num)
		counts[num]++
	}

	return result
}