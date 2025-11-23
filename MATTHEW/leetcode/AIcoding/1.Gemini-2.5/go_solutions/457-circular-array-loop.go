func circularArrayLoop(nums []int) bool {
	n := len(nums)

	// Helper function to get the next index in a circular array.
	// It also performs sign consistency checks and ensures the loop length is > 1.
	// Returns -1 if the path is invalid or leads to a length-1 loop.
	// Otherwise