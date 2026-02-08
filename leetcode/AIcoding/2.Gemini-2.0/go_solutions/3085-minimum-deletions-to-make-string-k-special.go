import "fmt"

func minDeletions(s string, k int) int {
	counts := make(map[rune]int)
	for _, char := range s {
		counts[char]++
	}

	freq := make([]int, 0)
	for _, count := range counts {
		freq = append(freq, count)
	}

	sort.Ints(freq)

	deletions := 0
	for i := len(freq) - 1; i >= 0; i-- {
		if freq[i] == 0 {
			continue
		}
		for i > 0 && freq[i] >= freq[i-1] && freq[i] > 0 {
			freq[i]--
			deletions++
		}
	}

	return deletions
}

import "sort"