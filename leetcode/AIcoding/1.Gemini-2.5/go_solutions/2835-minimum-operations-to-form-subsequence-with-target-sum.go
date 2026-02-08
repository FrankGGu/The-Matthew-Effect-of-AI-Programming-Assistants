func minOperations(nums []int, target int) int {
	// Step 1: Count frequencies of each power of 2 in nums.
	// Use a map to handle potentially large powers of 2 efficiently.
	counts := make(map[int]