import "sort"

func subsetsWithDup(nums []int) [][]int {
	sort.Ints(nums)
	result := [][]int{}
	var backtrack func(int, []int)
	backtrack = func(index int, subset []int) {
		temp := make([]int, len(subset))
		copy(temp, subset)
		result = append(result, temp)

		for i := index; i < len(nums); i++ {
			if i > index && nums[i] == nums[i-1] {
				continue
			}
			subset = append(subset, nums[i])
			backtrack(i+1, subset)
			subset = subset[:len(subset)-1]
		}
	}
	backtrack(0, []int{})
	return result
}