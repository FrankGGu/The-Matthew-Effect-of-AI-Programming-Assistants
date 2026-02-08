import (
	"sort"
	"strings"
)

func numSpecialEquivGroups(words []string) int {
	seen := make(map[string]bool)
	count := 0
	for _, word := range words {
		odd := []rune{}
		even := []rune{}
		for i, r := range word {
			if i%2 == 0 {
				even = append(even, r)
			} else {
				odd = append(odd, r)
			}
		}
		sort.Slice(even, func(i, j int) bool {
			return even[i] < even[j]
		})
		sort.Slice(odd, func(i, j int) bool {
			return odd[i] < odd[j]
		})
		key := string(even) + string(odd)
		if !seen[key] {
			seen[key] = true
			count++
		}
	}
	return count
}