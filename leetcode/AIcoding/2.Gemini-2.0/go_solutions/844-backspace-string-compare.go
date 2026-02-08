func backspaceCompare(s string, t string) bool {
	sStack := []rune{}
	tStack := []rune{}

	for _, r := range s {
		if r == '#' {
			if len(sStack) > 0 {
				sStack = sStack[:len(sStack)-1]
			}
		} else {
			sStack = append(sStack, r)
		}
	}

	for _, r := range t {
		if r == '#' {
			if len(tStack) > 0 {
				tStack = tStack[:len(tStack)-1]
			}
		} else {
			tStack = append(tStack, r)
		}
	}

	if len(sStack) != len(tStack) {
		return false
	}

	for i := 0; i < len(sStack); i++ {
		if sStack[i] != tStack[i] {
			return false
		}
	}

	return true
}