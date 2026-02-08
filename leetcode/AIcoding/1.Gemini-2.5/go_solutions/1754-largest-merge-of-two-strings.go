import (
	"strings"
)

func largestMerge(word1 string, word2 string) string {
	var res strings.Builder
	i, j := 0, 0
	for i < len(word1) || j < len(word2) {
		if i < len(word1) && j < len(word2) {
			if word1[i] > word2[j] {
				res.WriteByte(word1[i])
				i++
			} else if word2[j] > word1[i] {
				res.WriteByte(word2[j])
				j++
			} else { // word1[i] == word2[j]
				// Compare suffixes to decide which path leads to a lexicographically larger merge
				if word1[i:] > word2[j:] {
					res.WriteByte(word1[i])
					i++
				} else { // word2[j:] >= word1[i:]
					res.WriteByte(word2[j])
					j++
				}
			}
		} else if i < len(word1) { // word2 is exhausted
			res.WriteString(word1[i:])
			break
		} else { // word1 is exhausted
			res.WriteString(word2[j:])
			break
		}
	}
	return res.String()
}