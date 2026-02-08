import (
	"sort"
	"strings"
)

type Replacement struct {
	Index   int
	Source  string
	Target  string
}

func findReplaceString(s string, indices []int, sources []string, targets []string) string {
	replacements := make([]Replacement, len(indices))
	for i := range indices {
		replacements[i] = Replacement{
			Index:   indices[i],
			Source:  sources[i],
			Target:  targets[i],
		}
	}

	sort.Slice(replacements, func(i, j int) bool {
		return replacements[i].Index < replacements[j].Index
	})

	result := strings.Builder{}
	currentIndex := 0

	for _, replacement := range replacements {
		if replacement.Index < currentIndex {
			continue
		}

		result.WriteString(s[currentIndex:replacement.Index])

		if strings.HasPrefix(s[replacement.Index:], replacement.Source) {
			result.WriteString(replacement.Target)
			currentIndex = replacement.Index + len(replacement.Source)
		} else {
			result.WriteString(s[replacement.Index : replacement.Index+1])
			currentIndex = replacement.Index + 1
		}
	}

	result.WriteString(s[currentIndex:])
	return result.String()
}