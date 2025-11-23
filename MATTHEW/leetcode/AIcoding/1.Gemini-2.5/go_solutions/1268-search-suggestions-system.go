import (
	"sort"
)

type TrieNode struct {
	children    map[rune]*TrieNode
	suggestions []string
}

func searchSuggestionsSystem(products []string, searchWord string) [][]string {
	sort.Strings(products) // Sort products lexicographically

	root := &TrieNode{}
	for _, product := range products {
		curr := root
		for _, char := range product {
			if curr.children == nil {
				curr.children = make(map[rune]*TrieNode)
			}
			if _, ok := curr.children[char]; !ok {
				curr.children[char] = &TrieNode{}
			}
			curr = curr.children[char]

			curr.suggestions = append(curr.suggestions, product)
			if len(curr.suggestions) > 3 {
				curr.suggestions = curr.suggestions[:3]
			}
		}
	}

	result := [][]string{}
	curr := root
	found := true

	for _, char := range searchWord {
		if found {
			if curr.children != nil {
				if nextNode, ok := curr.children[char]; ok {
					curr = nextNode
					result = append(result, curr.suggestions)
				} else {
					found = false
					result = append(result, []string{})
				}
			} else {
				found = false
				result = append(result, []string{})
			}
		} else {
			result = append(result, []string{})
		}
	}

	return result
}