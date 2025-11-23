func findEvenNumbers(digits []int) []int {
	counts := make([]int, 10)
	for _, digit := range digits {
		counts[digit]++
	}

	result := []int{}

	for num := 100; num <= 998; num += 2 {
		h := num / 100
		t := (num / 10) % 10
		u := num % 10

		tempCounts := make([]int, 10)
		copy(tempCounts, counts)

		tempCounts[h]--
		tempCounts[t]--
		tempCounts[u]--

		if tempCounts[h] >= 0 && tempCounts[t] >= 0 && tempCounts[u] >= 0 {
			result = append(result, num)
		}
	}

	return result
}