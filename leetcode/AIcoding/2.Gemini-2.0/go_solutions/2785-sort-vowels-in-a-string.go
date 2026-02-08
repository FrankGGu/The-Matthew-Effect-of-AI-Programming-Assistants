import (
	"sort"
	"strings"
)

func sortVowels(s string) string {
	vowels := []rune{}
	indices := []int{}
	for i, r := range s {
		if strings.ContainsRune("aeiouAEIOU", r) {
			vowels = append(vowels, r)
			indices = append(indices, i)
		}
	}
	sort.Slice(vowels, func(i, j int) bool {
		return vowels[i] < vowels[j]
	})
	result := []rune(s)
	for i, index := range indices {
		result[index] = vowels[i]
	}
	return string(result)
}