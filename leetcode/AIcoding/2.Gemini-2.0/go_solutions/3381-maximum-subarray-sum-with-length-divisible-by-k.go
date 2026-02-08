func maxSubarraySumDivisibleByK(nums []int, k int) int {
	prefixSums := make([]int, len(nums)+1)
	for i := 1; i i++ {
		prefixSums[i] = (prefixSums[i-1] + nums[i-1]) % k
		if prefixSums[i] < 0 {
			prefixSums[i] += k
		}
	}

	firstOccurrence := make([]int, k)
	for i := range firstOccurrence {
		firstOccurrence[i] = -1
	}
	firstOccurrence[0] = 0

	maxLength := 0
	for i := 1; i <= len(nums); i++ {
		remainder := prefixSums[i]
		if firstOccurrence[remainder] == -1 {
			firstOccurrence[remainder] = i
		} else {
			maxLength = max(maxLength, i-firstOccurrence[remainder])
		}
	}

	return maxLength
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}