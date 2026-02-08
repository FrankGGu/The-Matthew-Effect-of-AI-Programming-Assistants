package main

func halvesAreAlike(s string) bool {
	n := len(s)
	mid := n / 2

	isVowel := func(ch byte) bool {
		switch ch {
		case 'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U':
			return true
		}
		return false
	}

	count1 := 0
	for i := 0; i < mid; i++ {
		if isVowel(s[i]) {
			count1++
		}
	}

	count2 := 0
	for i := mid; i < n; i++ {
		if isVowel(s[i]) {
			count2++
		}
	}

	return count1 == count2
}