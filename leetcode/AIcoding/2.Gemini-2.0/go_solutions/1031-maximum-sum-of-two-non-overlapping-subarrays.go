func maxSumTwoNoOverlap(nums []int, firstLen int, secondLen int) int {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 1; i <= n; i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i-1]
	}

	maxSum := 0
	maxSum = max(maxSum, solve(nums, prefixSum, firstLen, secondLen))
	maxSum = max(maxSum, solve(nums, prefixSum, secondLen, firstLen))

	return maxSum
}

func solve(nums []int, prefixSum []int, firstLen int, secondLen int) int {
	n := len(nums)
	maxFirst := 0
	maxSum := 0

	for i := firstLen + secondLen; i <= n; i++ {
		maxFirst = max(maxFirst, prefixSum[i-secondLen]-prefixSum[i-secondLen-firstLen])
		maxSum = max(maxSum, maxFirst+prefixSum[i]-prefixSum[i-secondLen])
	}

	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}