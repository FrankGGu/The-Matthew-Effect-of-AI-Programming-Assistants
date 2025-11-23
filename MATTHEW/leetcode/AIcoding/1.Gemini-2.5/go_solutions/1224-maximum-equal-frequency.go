package main

func maxEqualFreq(nums []int) int {
	countMap := make(map[int]int) // Stores frequency of each number: num -> frequency
	freqMap := make(map[int]int)  // Stores count of numbers for each frequency: frequency -> count of numbers
	maxF := 0                     // Maximum frequency encountered among all numbers
	maxLen := 0                   // Result: maximum length of a valid prefix

	for i := 0; i < len(nums); i++ {
		num := nums[i]

		// Before updating countMap for 'num', decrement the count for its old frequency in freqMap
		if countMap[num] > 0 {
			freqMap[countMap[num]]--
			// If no numbers have this frequency anymore, remove it from freqMap
			if freqMap[countMap[num]] == 0 {
				delete(freqMap, countMap[num])
			}
		}

		// Increment the frequency of 'num'
		countMap[num]++
		currentFreq := countMap[num]

		// Increment the count for the new frequency in freqMap
		freqMap[currentFreq]++

		// Update maxF if currentFreq is higher
		if currentFreq > maxF {
			maxF = currentFreq
		}

		// Check if the current prefix nums[0...i] is valid
		isValid := false

		// Condition 1: All elements in the prefix appear exactly once.
		// Example: [1,2,3,4]. If we remove any one, all others still appear once.
		// This means maxF must be 1.
		if maxF == 1 {
			isValid = true
		} else if len(countMap) == 1 {
			// Condition 2: There is only one unique element in the prefix.
			// Example: [7,7,7,7]. If we remove one '7', remaining '7's all have frequency 3.
			// This means len(countMap) is 1. maxF can be any value.
			isValid = true
		} else if freqMap[1] == 1 && freqMap[maxF] == len(countMap)-1 {
			// Condition 3: All elements have frequency 'maxF', except one element that has frequency '1'.
			// Example: [1,1,2,2,3]. Here maxF=2. One element (3) has freq 1, others (1,2) have freq 2.
			// If we remove the element with frequency 1 (i.e., '3'), all remaining elements (1,1,2,2) have frequency 2.
			// This means freqMap[1] is 1, and freqMap[maxF] is len(countMap)-1.
			isValid = true
		} else if freqMap[maxF] == 1 && freqMap[maxF-1] == len(countMap)-1 {
			// Condition 4: All elements have frequency 'maxF-1', except one element that has frequency 'maxF'.
			// Example: [1,1,1,2,2]. Here maxF=3. One element (1) has freq 3, others (2) have freq 2.
			// If we remove one instance of the element with frequency maxF (i.e., one '1'),
			// then '1' becomes frequency 2, and all elements (1,1,2,2) have frequency 2.
			// This means freqMap[maxF] is 1, and freqMap[maxF-1] is len(countMap)-1.
			isValid = true
		}

		if isValid {
			maxLen = i + 1
		}
	}
	return maxLen
}