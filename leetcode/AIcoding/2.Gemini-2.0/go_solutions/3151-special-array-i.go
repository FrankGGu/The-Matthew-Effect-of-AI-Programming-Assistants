import "sort"

func specialArray(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	for i := 1; i <= n; i++ {
		count := 0
		for j := 0; j < n; j++ {
			if nums[j] >= i {
				count = n - j
				break
			}
		}
		if count == i {
			return i
		}
	}
	return -1
}