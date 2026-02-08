import "sort"

func targetIndices(nums []int, target int) []int {
	sort.Ints(nums)
	result := []int{}
	for i, num := range nums {
		if num == target {
			result = append(result, i)
		}
	}
	return result
}