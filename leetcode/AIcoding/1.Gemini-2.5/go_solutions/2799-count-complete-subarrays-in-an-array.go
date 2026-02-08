package main

func countCompleteSubarrays(nums []int) int {
	distinctInNums := make(map[int]struct{})
	for _, num := range nums {
		distinctInNums[num] = struct{}{}
	}
	k := len(distinctInNums)

	count := 0
	n := len(nums)

	for i := 0; i < n; i++ {
		currentFreq := make(map[int]int)
		currentDistinctCount := 0
		for j := i; j < n; j++ {
			num := nums[j]
			if currentFreq[num] == 0 {
				currentDistinctCount++
			}
			currentFreq[num]++

			if currentDistinctCount == k {
				count++
			}
		}
	}

	return count
}