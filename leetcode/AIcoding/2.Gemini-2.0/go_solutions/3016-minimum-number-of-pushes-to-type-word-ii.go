import (
	"sort"
)

func minimumPushes(word string) int {
	freq := make([]int, 26)
	for _, char := range word {
		freq[char-'a']++
	}

	sort.Sort(sort.Reverse(sort.IntSlice(freq)))

	totalPushes := 0
	for i := 0; i < 26; i++ {
		pushes := (i / 8) + 1
		totalPushes += pushes * freq[i]
	}

	return totalPushes
}