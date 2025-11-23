func countAdjacent(nums []int, i int) int {
	count := 0
	if i > 0 && nums[i] == nums[i-1] {
		count++
	}
	if i < len(nums)-1 && nums[i] == nums[i+1] {
		count++
	}
	return count
}

func colorTheArray(n int, queries [][]int) []int {
	nums := make([]int, n)
	result := make([]int, len(queries))
	adjacent := 0
	for i := 0; i < len(queries); i++ {
		index := queries[i][0]
		color := queries[i][1]

		adjacent -= countAdjacent(nums, index)

		nums[index] = color

		adjacent += countAdjacent(nums, index)
		result[i] = adjacent
	}
	return result
}