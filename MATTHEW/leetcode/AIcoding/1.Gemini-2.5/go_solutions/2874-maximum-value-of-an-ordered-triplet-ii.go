import "math"

func maximumTripletValue(nums []int) int64 {
	n := len(nums)
	if n < 3 {
		return 0
	}

	// max_prefix_val[i] stores the maximum value of nums[x] for x <= i
	maxPrefixVal