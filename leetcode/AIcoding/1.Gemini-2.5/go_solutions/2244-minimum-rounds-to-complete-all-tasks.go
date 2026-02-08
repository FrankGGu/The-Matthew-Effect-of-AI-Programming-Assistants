package main

func minimumRounds(tasks []int) int {
	freq := make(map[int]int)
	for _, task := range tasks {
		freq[task]++
	}

	totalRounds := 0
	for _, count := range freq {
		if count == 1 {
			return -1
		}

		roundsForDifficulty := count / 3
		if count%3 != 0 {
			roundsForDifficulty++
		}
		totalRounds += roundsForDifficulty
	}

	return totalRounds
}