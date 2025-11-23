import "sort"

func specialArray(nums []int) int {
	sort.Ints(nums)
	n := len(nums)

	for x := 0; x <= n; x++ {
		// Find the count of numbers greater than or equal to x.
		// Since nums is sorted, we can find the