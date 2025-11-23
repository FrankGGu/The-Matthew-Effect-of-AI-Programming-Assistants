func countPartitions(nums []int) int {
	MOD := 1_000_000_007

	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}

	if totalSum%2 != 0 {
		return 0
	}

	n := len(nums)

	result := 1
	for i := 0; i < n; i++ {
		result = (result * 2) % MOD
	}

	return result
}