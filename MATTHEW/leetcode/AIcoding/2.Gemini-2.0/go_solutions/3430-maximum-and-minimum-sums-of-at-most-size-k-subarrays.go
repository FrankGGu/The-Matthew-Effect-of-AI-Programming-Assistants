func maxSum(nums []int, k int) int {
	n := len(nums)
	maxSum := -1 << 62
	for i := 0; i < n; i++ {
		currSum := 0
		for j := i; j < n && j-i+1 <= k; j++ {
			currSum += nums[j]
			if currSum > maxSum {
				maxSum = currSum
			}
		}
	}
	return maxSum
}

func minSum(nums []int, k int) int {
	n := len(nums)
	minSum := 1 << 62
	for i := 0; i < n; i++ {
		currSum := 0
		for j := i; j < n && j-i+1 <= k; j++ {
			currSum += nums[j]
			if currSum < minSum {
				minSum = currSum
			}
		}
	}
	return minSum
}