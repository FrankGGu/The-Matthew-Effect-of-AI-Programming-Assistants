package main

func maxFrequencyElements(nums []int) int {
	freqMap := make(map[int]int)
	for _, num := range nums {
		freqMap[num]++
	}

	maxFreq := 0
	for _, freq := range freqMap {
		if freq > maxFreq {
			maxFreq = freq
		}
	}

	countMaxFreqElements := 0
	for _, freq := range freqMap {
		if freq == maxFreq {
			countMaxFreqElements++
		}
	}

	return countMaxFreqElements * maxFreq
}