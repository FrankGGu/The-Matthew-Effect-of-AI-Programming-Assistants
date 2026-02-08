import "sort"

func longestWord(words []string) string {
	sort.Strings(words)
	set := make(map[string]bool)
	set[""] = true
	ans := ""
	for _, word := range words {
		if set[word[:len(word)-1]] {
			set[word] = true
			if len(word) > len(ans) {
				ans = word
			}
		}
	}
	return ans
}