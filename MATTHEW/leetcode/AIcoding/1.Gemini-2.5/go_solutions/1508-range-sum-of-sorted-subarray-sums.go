func rangeSum(nums []int, n int, left int, right int) int {
	allSubarraySums := make([]int, 0, n*(n+1)/2)

	// Generate all subarray sums
	for i := 0; i < n; i++ {
		currentSum := 0
		for j := i; j < n; j++ {
			currentSum += nums[j]
			allSubarraySums = append(allSubarraySums, currentSum)
		}
	}

	// Sort the subarray sums in non-decreasing order
	sort.Ints(allSubarraySums)

	// Calculate the sum of elements in the specified range (1-indexed to 0-indexed)
	mod := 1_000_000_007
	var