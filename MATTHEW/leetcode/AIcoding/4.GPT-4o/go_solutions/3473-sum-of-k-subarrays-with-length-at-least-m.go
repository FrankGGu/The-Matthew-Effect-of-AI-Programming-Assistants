func maxSumOfSubarrays(arr []int, k int, m int) int {
	n := len(arr)
	if n < k {
		return 0
	}

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + arr[i]
	}

	maxSum := 0
	for i := 0; i <= n-k; i++ {
		for j := i + k - 1; j < n; j++ {
			if j-i+1 >= m {
				currentSum := prefixSum[j+1] - prefixSum[i]
				if currentSum > maxSum {
					maxSum = currentSum
				}
			}
		}
	}

	return maxSum
}