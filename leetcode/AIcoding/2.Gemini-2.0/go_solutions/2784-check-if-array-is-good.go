import "sort"

func isGood(nums []int) bool {
	n := len(nums)
	sort.Ints(nums)
	if nums[n-1] != nums[n-2] {
		return false
	}
	for i := 0; i < n-2; i++ {
		if nums[i] != i+1 {
			return false
		}
	}
	if nums[n-2] != n-1 {
		return false
	}
	return true
}