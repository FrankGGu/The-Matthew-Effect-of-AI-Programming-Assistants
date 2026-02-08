func findSecretWord(wordlist []string) {
	n := len(wordlist)
	for i := 0; i < 10; i++ {
		guess := wordlist[0]
		match := guessWord(guess)
		if match == 6 {
			return
		}
		newList := make([]string, 0)
		for _, w := range wordlist {
			if matches(guess, w) == match {
				newList = append(newList, w)
			}
		}
		wordlist = newList
		if len(wordlist) == 0 {
			return
		}

	}
}

func matches(w1, w2 string) int {
	count := 0
	for i := 0; i < 6; i++ {
		if w1[i] == w2[i] {
			count++
		}
	}
	return count
}

func guessWord(word string) int {
	return 0
}