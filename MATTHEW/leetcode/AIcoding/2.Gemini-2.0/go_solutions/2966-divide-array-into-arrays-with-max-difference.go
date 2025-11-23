import "sort"

func divideArray(nums []int, k int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	for i := 0; i < len(nums); i += 3 {
		if nums[i+2]-nums[i] > k {
			return [][]int{}
		}
		result = append(result, []int{nums[i], nums[i+1], nums[i+2]})
	}
	return result
}