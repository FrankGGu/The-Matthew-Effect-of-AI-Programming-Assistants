func sumSubarrayDistinctElementsSquaresII(nums []int) int {
	n := len(nums)
	MOD := 1_000_000_007

	totalSum := 0
	lastOccurrence := make(map[int]int)

	for j := 0; j < n; j++ {
		val := nums[j]

		prevIdx := -1
		if idx, ok := lastOccurrence[val]; ok {
			prevIdx = idx
		}

		valSq := (int64(val) * int64(val)) % int64(MOD)

		leftCount := j - prevIdx
		rightCount := n - j

		term := (valSq * int64(leftCount)) % int64(MOD)
		term = (term * int64(rightCount)) % int64(MOD)

		totalSum = (totalSum + int(term)) % MOD

		lastOccurrence[val] = j
	}

	return totalSum
}