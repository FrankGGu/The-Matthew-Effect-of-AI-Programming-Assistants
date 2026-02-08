func maxRepOpt1(text string) int {
	count := make(map[rune]int)
	for _, r := range text {
		count[r]++
	}

	ans := 0
	for i := 0; i < len(text); i++ {
		j := i
		for j < len(text) && text[j] == text[i] {
			j++
		}
		length := j - i

		if length < count[rune(text[i])] {
			ans = max(ans, length+1)
		} else {
			ans = max(ans, length)
		}

		k := j + 1
		for k < len(text) && text[k] == text[i] {
			k++
		}

		length2 := k - j - 1
		if length2 > 0 {
			if length+length2 < count[rune(text[i])] {
				ans = max(ans, length+length2+1)
			} else {
				ans = max(ans, length+length2)
			}
		}
		i = j - 1
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}