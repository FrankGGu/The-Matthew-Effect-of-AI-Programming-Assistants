package main

func findLHS(nums []int) int {
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	maxLength := 0

	for num, count := range freqMap {
		if countPlusOne, exists := freqMap[num+1]; exists {
			currentLength := count + countPlusOne
			if currentLength > maxLength {
				maxLength = currentLength
			}
		}
	}

	return maxLength
}