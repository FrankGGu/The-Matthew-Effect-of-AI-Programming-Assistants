func longestBeautifulSubstring(word string) int {
	ans := 0
	count := 0
	vowels := "aeiou"
	idx := 0
	for i := 0; i < len(word); i++ {
		if idx < 5 && word[i] == vowels[idx] {
			count++
			if idx < 4 && i+1 < len(word) && word[i+1] == vowels[idx+1] {
				idx++
			}
		} else if idx > 0 && word[i] == vowels[idx-1] {
			count++
		} else if word[i] == 'a' {
			count = 1
			idx = 0
		} else {
			count = 0
			idx = 0
		}

		if idx == 4 {
			if count > ans {
				ans = count
			}
		}
	}
	return ans
}