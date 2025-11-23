import (
	"sort"
)

func maxDistinctElements(nums []int, k int) int {
	counts := make(map[int]int)
	for _, num := range nums {
		counts[num]++
	}

	freq := []int{}
	for _, count := range counts {
		freq = append(freq, count)
	}

	sort.Ints(freq)

	distinct := len(freq)
	for i := 0; i < len(freq); i++ {
		if freq[i]-1 <= k {
			k -= (freq[i] - 1)
			distinct--
		} else {
			break
		}
	}

	if k > 0 {
		distinct -= k / 2
	}

	if distinct < 0 {
		return 0
	}

	return distinct
}