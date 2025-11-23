func minScore(nums []int) int {
	n := len(nums)

	// If n is 3, we can change two elements, leaving one. The score will be 0.
	// This is covered by the general logic, but can be a quick exit.
	if