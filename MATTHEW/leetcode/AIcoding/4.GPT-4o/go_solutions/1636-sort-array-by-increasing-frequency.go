import "sort"

func frequencySort(nums []int) []int {
	count := make(map[int]int)
	for _, num := range nums {
		count[num]++
	}

	type pair struct {
		num   int
		freq  int
	}

	pairs := make([]pair, 0, len(count))
	for num, freq := range count {
		pairs = append(pairs, pair{num, freq})
	}

	sort.Slice(pairs, func(i, j int) bool {
		if pairs[i].freq == pairs[j].freq {
			return pairs[i].num > pairs[j].num
		}
		return pairs[i].freq < pairs[j].freq
	})

	result := make([]int, 0, len(nums))
	for _, p := range pairs {
		for i := 0; i < p.freq; i++ {
			result = append(result, p.num)
		}
	}
	return result
}