import "sort"

func targetIndices(nums []int, target int) []int {
	sort.Ints(nums)
	var result []int
	for i, num := range nums {
		if num == target {
			result = append(result, i)
		} else if num > target {
			// Since the array is sorted, if we encounter a number greater than target,
			// there's no need to check further.
			break
		}
	}
	return result
}