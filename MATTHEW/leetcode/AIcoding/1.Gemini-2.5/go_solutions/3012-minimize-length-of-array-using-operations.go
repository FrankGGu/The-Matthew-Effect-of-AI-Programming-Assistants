package main

func minLengthAfterRemovals(nums []int) int {
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	minLength := 0
	for _, count := range freqMap {
		if count%2 != 0 {
			minLength++
		}
	}

	return minLength
}