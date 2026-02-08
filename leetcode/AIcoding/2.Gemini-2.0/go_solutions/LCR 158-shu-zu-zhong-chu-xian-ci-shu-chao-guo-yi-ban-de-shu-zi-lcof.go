import "sort"

func findLeastNumOfUniqueInts(arr []int, k int) int {
	counts := make(map[int]int)
	for _, num := range arr {
		counts[num]++
	}

	freq := []int{}
	for _, count := range counts {
		freq = append(freq, count)
	}

	sort.Ints(freq)

	removed := 0
	for i := 0; i < len(freq); i++ {
		if k >= freq[i] {
			k -= freq[i]
			removed++
		} else {
			break
		}
	}

	return len(freq) - removed
}