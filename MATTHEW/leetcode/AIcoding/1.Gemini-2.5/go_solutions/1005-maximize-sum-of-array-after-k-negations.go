func largestSumAfterKNegations(nums []int, k int) int {
	// Sort the array to easily pick the smallest (most negative) numbers first.
	sort.Ints(nums)

	// Negate negative numbers to maximize the sum.
	// We iterate through the sorted array and negate