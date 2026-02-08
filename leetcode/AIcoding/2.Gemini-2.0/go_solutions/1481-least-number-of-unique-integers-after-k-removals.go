import "sort"

func findLeastNumOfUniqueInts(arr []int, k int) int {
	counts := make(map[int]int)
	for _, num := range arr {
		counts[num]++
	}

	freqs := []int{}
	for _, count := range counts {
		freqs = append(freqs, count)
	}

	sort.Ints(freqs)

	uniqueCount := len(freqs)
	for i := 0; i < len(freqs); i++ {
		if k >= freqs[i] {
			k -= freqs[i]
			uniqueCount--
		} else {
			break
		}
	}

	return uniqueCount
}