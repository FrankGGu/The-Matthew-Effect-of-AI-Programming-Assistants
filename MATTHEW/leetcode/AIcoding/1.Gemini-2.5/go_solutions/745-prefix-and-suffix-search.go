type WordFilter struct {
	weights map[string]int
}

func Constructor(words []string) WordFilter {
	wf := WordFilter{
		weights: make(map[string]int),
	}

	for i, word := range words {
		n := len(word)
		for pLen := 1; pLen <= n; pLen++ {
			prefix := word[:pLen]
			for sLen := 1; sLen <= n; sLen++ {
				suffix := word[n-sLen:]
				key := prefix + "#" + suffix
				wf.weights[key] = i
			}
		}
	}

	return wf
}

func (this *WordFilter) F(prefix string, suffix string) int {
	key := prefix + "#" + suffix
	if val, ok := this.weights[key]; ok {
		return val
	}
	return -1
}