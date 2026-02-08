import "sort"

func isPossibleToSplit(nums []int) bool {
	n := len(nums)
	if n%2 != 0 {
		return false
	}

	sort.Ints(nums)

	for i := 0; i < n; i += 2 {
		if i+1 < n && nums[i] != nums[i+1] {
			return false
		}
	}

	return true
}