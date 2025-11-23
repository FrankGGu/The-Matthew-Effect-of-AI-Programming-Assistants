package main

func subarraySum(nums []int, k int) int {
	count := 0
	currentSum := 0
	prefixSumFreq := make(map[int]int)
	prefixSumFreq[0] = 1

	for _, num := range nums {
		currentSum += num
		if freq, ok := prefixSumFreq[currentSum-k]; ok {
			count += freq
		}
		prefixSumFreq[currentSum]++
	}

	return count
}