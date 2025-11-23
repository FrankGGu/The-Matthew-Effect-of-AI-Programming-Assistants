package main

func minOperations(nums []int, k int) int {
	n := len(nums)
	totalOperations := 0

	for i := 0; i < k; i++ {
		counts := make(map[int]int)
		maxFreq := 0
		subsequenceLength := 0

		for j := i; j < n; j += k {
			num := nums[j]
			counts[num]++
			if counts[num] > maxFreq {
				maxFreq = counts[num]
			}
			subsequenceLength++
		}

		totalOperations += subsequenceLength - maxFreq
	}

	return totalOperations
}