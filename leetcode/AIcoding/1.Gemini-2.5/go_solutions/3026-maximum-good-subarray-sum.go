func maximumGoodSubarraySum(nums []int, k int) int64 {
	maxSum := int64(math.MinInt64)

	// minPrefixSumMap stores the minimum prefix sum encountered for a specific number.
	// The key is the number (nums[i