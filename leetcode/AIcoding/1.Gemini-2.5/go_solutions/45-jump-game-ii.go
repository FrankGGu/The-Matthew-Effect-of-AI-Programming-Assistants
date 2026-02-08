func jump(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	jumps := 0
	currentReach := 0 // The maximum index that can be reached with the current number of jumps
	nextReach := 0    // The maximum index that can be reached