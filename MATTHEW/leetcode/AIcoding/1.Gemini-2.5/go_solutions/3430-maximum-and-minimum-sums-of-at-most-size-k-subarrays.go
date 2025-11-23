import "container/list"

func maxMinSumSubarrays(nums []int, k int) []int {
	n := len(nums)
	if n == 0 {
		return []int{0, 0}
	}

	prefixSum := make([]int, n+1)
	for i := 0; i <