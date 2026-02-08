package main

import "math"

func mostFrequentEven(nums []int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		if num%2 == 0 {
			counts[num]++
		}
	}

	maxFreq := 0
	result := -1

	for num, freq := range counts {
		if freq > maxFreq {
			maxFreq = freq
			result = num
		} else if freq == maxFreq {
			if result == -1 || num < result { // result == -1 handles the first even number found
				result = num
			}
		}
	}

	return result
}