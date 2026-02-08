func mostFrequentIDs(nums []int, freq []int) []int {
	idToFreq := make(map[int]int)         // ID -> current_frequency
	freqToCount := make(map[int]int)      // frequency -> count_of_IDs_with