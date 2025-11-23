import (
	"sort"
	"strings"
)

func groupAnagrams(strs []string) [][]string {
	anagramMap := make(map[string][]string)

	for _, s := range strs {
		chars := []rune(s)
		sort.Slice(chars, func(i, j int) bool {
			return chars[i] < chars[j]
		})
		sortedStr := string(chars)
		anagramMap[sortedStr] = append(anagramMap[sortedStr], s)
	}

	result := make([][]string, 0, len(anagramMap))
	for _, group := range anagramMap {
		result = append(result, group)
	}

	return result
}