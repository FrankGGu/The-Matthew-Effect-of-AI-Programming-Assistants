import (
	"sort"
)

func minDeletions(s string) int {
	freq := make([]int, 26)
	for _, r := range s {
		freq[r-'a']++
	}

	sort.Sort(sort.Reverse(sort.IntSlice(freq)))

	deletions := 0
	seen := make(map[int]bool)

	for i := 0; i < 26; i++ {
		if freq[i] == 0 {
			break
		}

		for freq[i] > 0 && seen[freq[i]] {
			freq[i]--
			deletions++
		}

		seen[freq[i]] = true
	}

	return deletions
}