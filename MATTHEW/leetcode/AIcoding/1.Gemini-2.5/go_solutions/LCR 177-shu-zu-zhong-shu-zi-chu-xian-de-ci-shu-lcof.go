package main

func numIdenticalPairs(nums []int) int {
	freq := make(map[int]int)
	for _, num := range nums {
		freq[num]++
	}

	totalGoodPairs := 0
	for _, count := range freq {
		totalGoodPairs += count * (count - 1) / 2
	}

	return totalGoodPairs
}