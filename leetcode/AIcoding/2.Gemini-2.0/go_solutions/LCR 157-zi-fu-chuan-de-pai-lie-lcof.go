import "sort"

func permute(nums []int) [][]int {
	sort.Ints(nums)
	var res [][]int
	var backtrack func(arr []int, used []bool, path []int)
	backtrack = func(arr []int, used []bool, path []int) {
		if len(path) == len(nums) {
			temp := make([]int, len(path))
			copy(temp, path)
			res = append(res, temp)
			return
		}
		for i := 0; i < len(nums); i++ {
			if used[i] {
				continue
			}
			if i > 0 && nums[i] == nums[i-1] && !used[i-1] {
				continue
			}
			used[i] = true
			path = append(path, nums[i])
			backtrack(arr, used, path)
			path = path[:len(path)-1]
			used[i] = false
		}
	}
	used := make([]bool, len(nums))
	backtrack(nums, used, []int{})
	return res
}