func maxSumOfThreeSubarrays(nums []int, k int) []int {
	n := len(nums)
	sum := make([]int, n+1)
	for i := 0; i < n; i++ {
		sum[i+1] = sum[i] + nums[i]
	}

	leftMaxIdx := make([]int, n)
	leftMaxSum := 0
	leftMaxIdx[0] = 0
	for i := k; i <= n-2*k; i++ {
		if sum[i+k]-sum[i] > leftMaxSum {
			leftMaxSum = sum[i+k] - sum[i]
			leftMaxIdx[i] = i
		} else {
			leftMaxIdx[i] = leftMaxIdx[i-1]
		}
	}

	rightMaxIdx := make([]int, n)
	rightMaxSum := 0
	rightMaxIdx[n-k] = n - k
	for i := n - k - 1; i >= 2*k; i-- {
		if sum[i+k]-sum[i] >= rightMaxSum {
			rightMaxSum = sum[i+k] - sum[i]
			rightMaxIdx[i] = i
		} else {
			rightMaxIdx[i] = rightMaxIdx[i+1]
		}
	}

	maxSum := 0
	res := []int{0, 0, 0}
	for j := k; j <= n-2*k; j++ {
		l := leftMaxIdx[j-1]
		r := rightMaxIdx[j+k]
		curSum := (sum[l+k] - sum[l]) + (sum[j+k] - sum[j]) + (sum[r+k] - sum[r])
		if curSum > maxSum {
			maxSum = curSum
			res[0] = l
			res[1] = j
			res[2] = r
		}
	}
	return res
}