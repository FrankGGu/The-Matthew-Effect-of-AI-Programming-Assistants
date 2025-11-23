func maxSumOfThreeSubarrays(nums []int, k int) []int {
	n := len(nums)

	N_sub := n - k + 1
	sums := make([]int, N_sub)

	currentSum := 0
	for i := 0; i < k; i++ {
		currentSum += nums[i]
	}
	sums[0] = currentSum

	for i := 1; i < N_sub; i++ {
		currentSum = currentSum - nums[i-1] + nums[i+k-1]
		sums[i] = currentSum
	}

	left := make([]int, N_sub)
	left[0] = 0
	for i := 1; i < N_sub; i++ {
		if sums[i] > sums[left[i-1]] {
			left[i] = i
		} else {
			left[i] = left[i-1]
		}
	}

	right := make([]int, N_sub)
	right[N_sub-1] = N_sub - 1
	for i := N_sub - 2; i >= 0; i-- {
		if sums[i] >= sums[right[i+1]] {
			right[i] = i
		} else {
			right[i] = right[i+1]
		}
	}

	maxSum := -1
	result := make([]int, 3)

	for j := k; j <= N_sub-k-1; j++ {
		i := left[j-k]
		p := right[j+k]

		currentTotalSum := sums[i] + sums[j] + sums[p]

		if currentTotalSum > maxSum {
			maxSum = currentTotalSum
			result[0] = i
			result[1] = j
			result[2] = p
		}
	}

	return result
}