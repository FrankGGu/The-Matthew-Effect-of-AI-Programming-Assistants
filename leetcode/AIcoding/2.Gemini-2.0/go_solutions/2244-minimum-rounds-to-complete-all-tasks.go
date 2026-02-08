func minimumRounds(tasks []int) int {
	freq := make(map[int]int)
	for _, task := range tasks {
		freq[task]++
	}

	rounds := 0
	for _, count := range freq {
		if count == 1 {
			return -1
		}
		rounds += (count + 2) / 3
	}

	return rounds
}